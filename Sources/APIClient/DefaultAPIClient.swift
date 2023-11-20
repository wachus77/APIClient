//
//  DefaultAPIClient.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

public final class DefaultAPIClient: APIClient {
    
    // MARK: Properties
    
    /// - SeeAlso: APIClient.configuration
    public let configuration: APIClientConfiguration
    
    /// An instance of url session perfoming requests.
    private var urlSession: URLSession
    
    // MARK: Initialization
    
    /// Initializes an instance of the receiver.
    ///
    /// - Parameters:
    ///   - configuration: A base configuration of the client
    ///   - urlSession: URL session as a main interface for performing requests.
    public init(configuration: APIClientConfiguration, urlSession: URLSession = .shared) {
        self.configuration = configuration
        self.urlSession = urlSession
    }
    
    /// Performs the API request
    public func request<Request>(request: Request) async throws -> Request.Response where Request: APIRequest {
        guard let urlRequest = try? request.build(againstBaseURL: configuration.baseURL, defaultHeaders: configuration.defaultHeaders) else {
            throw APIError.urlRequestCreationFailed
        }
        
        // Print to console if configured.
        if configuration.printRequests {
            print("------------------------------")
            print(request.debugDescription)
            print("Default HTTP headers: \(configuration.defaultHeaders)")
            print(configuration.baseURL)
            print("BUILT URL REQUEST: \(urlRequest.debugDescription)")
        }
        
        return try await self.decodeResponse(request, dataWithResponse: urlSession.data(for: urlRequest))
    }
}

extension DefaultAPIClient {
    private func decodeResponse<Request, T: Decodable>(_ request: Request, dataWithResponse: (data: Data, response: URLResponse)) async throws -> T where Request: APIRequest {
        guard let response = dataWithResponse.response as? HTTPURLResponse else {
            throw APIError.conversionToHTTPURLResponseFailed
        }
        
        // Print to console if configured.
        if self.configuration.printResponses {
            print("------------------------------")
            do {
                debugPrint(response)
                debugPrint(try JSONSerialization.jsonObject(with: dataWithResponse.data))
            } catch {
                print("Encoutered an error when serializing json object: \(error)")
            }
        }
        
        // error parsing
        let customErrorType = Request.CustomError.self
        let customErrorDecoder = customErrorType.decoder
        let customError = try? customErrorDecoder.decode(
            customErrorType.self,
            from: dataWithResponse.data)
        
        switch response.statusCode {
        case 200...299:
            break
        case 400:
            throw APIError.badRequest(errorCode: response.statusCode, customError: customError)
        case 401:
            throw APIError.unAuthorised(errorCode: response.statusCode, customError: customError)
        case 404:
            throw APIError.notFound(errorCode: response.statusCode, customError: customError)
        case 400 ... 499:
            break
        case 500 ... 599:
            throw APIError.serverError(errorCode: response.statusCode, customError: customError)
        default:
            throw APIError.some(errorCode: response.statusCode, customError: customError)
        }
        
        // response parsing
        let decoder = Request.Response.decoder
        
        return try decoder.decode(
            T.self,
            from: dataWithResponse.data
        )
    }
}
