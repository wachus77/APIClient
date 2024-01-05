//
//  APIRequest.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

public enum ContentType {
    case applicationJson
    case multipartFormData
    case none
}

/// An API request representation that can build a `URLRequest` and be encoded.
public protocol APIRequest: Encodable {
    /// The type of a response.
    associatedtype Response: APIResponse
    
    /// The type of an custom error.
    associatedtype CustomError: APICustomError

    /// Content-Type of the request
    var contentType: ContentType { get }
    
    /// Returns a string that describes the contents of the request for presentation in the debugger.
    var debugDescription: String { get }

    /// An encoder to be used when encoding a request.
    var encoder: JSONEncoder { get }
    
    /// Builds the request against the given `baseURL`.
    ///
    /// - Parameters:
    ///     - baseURL: The base URL to resolve the URL against.
    ///     - defaultHeaders: Default HTTP headers of the request.
    ///
    /// - Throws: Any error that occurred during request building.
    ///
    /// - Returns: A built URL request instance.
    func build(againstBaseURL baseURL: URL, defaultHeaders: [String: String]) throws -> URLRequest
}

extension APIRequest {
    
    /// - SeeAlso: APIRequest.CustomError
    public typealias CustomError = DefaultCustomAPIError
    
    /// - SeeAlso: APIRequest.ContentType
    var contentType: ContentType {
        .none
    }

    /// - SeeAlso: APIRequest.encoder
    public var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        return encoder
    }
}




