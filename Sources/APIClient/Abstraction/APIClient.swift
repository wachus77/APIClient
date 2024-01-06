//
//  APIClient.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

/// Performs API requests.
public protocol APIClient {
    /// The configuration of the client.
    var configuration: APIClientConfiguration { get }
    /// Performs the API request
    func request<Request>(request: Request) async throws -> Request.Response where Request: APIRequest
    /// Performs the API request
    func request<Request>(request: Request) async throws -> Data where Request: APIRequestModelWithSimpleDataResponse
}
