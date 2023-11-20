//
//  APIClientConfiguration.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

/// String representation of the scheme.
public enum Scheme: String {
    /// Regular communication protocol.
    case http
    /// Secure communication protocol.
    case https
}

/// Configuration required by API client to work properly.
public protocol APIClientConfiguration {
    /// The scheme subcomponent of the URL.
    var scheme: Scheme { get }

    /// The host subcomponent.
    var host: String { get }
    
    /// General API path
    var generalAPIPath: String? { get }

    /// URL initialized from scheme and host.
    var baseURL: URL { get }
    
    /// Default headers to be use in every request
    var defaultHeaders: [String: String] { get }
    
    /// Indicates whether responses should be printed to console window.
    var printResponses: Bool { get }

    /// Indicates whether requests should be printed to console window.
    var printRequests: Bool { get }
}

extension APIClientConfiguration {
    /// - SeeAlso: APIClientConfiguration.baseURL
    public var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        if let generalAPIPath = generalAPIPath {
            components.path = generalAPIPath
        }
        return components.url!
    }
}
