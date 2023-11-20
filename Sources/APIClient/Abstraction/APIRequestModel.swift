//
//  APIRequestModel.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

/// An API request model.
public protocol APIRequestModel: APIRequest {
    /// HTTP method of the request.
    var method: APIRequestMethod { get }

    /// Path of the request. Will be resolved against base URL.
    var path: String { get }

    /// An array of query items for the URL in the order in which they appear in the original query string.
    var queryItems: [URLQueryItem]? { get }

    /// HTTP headers of the request.
    var headers: [String: String] { get }
}

extension APIRequestModel {

    /// - SeeAlso: APIRequest.headers
    public var headers: [String: String] {
        return [:]
    }

    /// - SeeAlso: APIRequest.queryItems
    public var queryItems: [URLQueryItem]? {
        nil
    }
    
    /// - SeeAlso: APIRequest.debugDescription
    public var debugDescription: String {
        let body: String = {
            guard let bodyData = try? JSONEncoder().encode(self) else { return "no body" }
            return String(data: bodyData, encoding: .utf8) ?? ""
        }()
        return """
        HTTP method: \(method.rawValue),\n
        Path: \(path),\n
        HTTP headers: \(headers),\n
        Query items: \(String(describing: queryItems)),\n
        JSON body: \(body)\n
        """
    }

    /// - SeeAlso: APIRequest.build(againstBaseURL:defaultHeaders:)
    public func build(againstBaseURL baseURL: URL, defaultHeaders: [String: String]) throws -> URLRequest {
        var request = URLRequest(url: buildURL(againstBaseURL: baseURL))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders.appending(elementsOf: headers)
        if isRequestWithHttpBody {
            request.httpBody = try encoder.encode(self)
        }
        return request
    }
}

extension APIRequestModel {
    private func buildURL(againstBaseURL baseURL: URL) -> URL {
        var components = URLComponents()
        components.path = baseURL.path + path
        components.queryItems = queryItems
        return components.url(relativeTo: baseURL)!
    }
}
