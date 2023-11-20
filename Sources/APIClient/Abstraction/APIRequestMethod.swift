//
//  APIRequestMethod.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

/// A HTTP requets method.
public enum APIRequestMethod: String {
    /// HTTP GET request.
    case get = "GET"
    /// HTTP POST request.
    case post = "POST"
    /// HTTP PUT request.
    case put = "PUT"
    /// HTTP PATCH request.
    case patch = "PATCH"
    /// HTTP OPTIONS request.
    case options = "OPTIONS"
    /// HTTP DELETE request.
    case delete = "DELETE"
}

