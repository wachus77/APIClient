//
//  DefaultAPIClientConfiguration.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

public struct DefaultAPIClientConfiguration: APIClientConfiguration {
    // MARK: Properties
    
    /// - SeeAlso: APIClientConfiguration.scheme
    public let scheme: Scheme
    
    /// - SeeAlso: APIClientConfiguration.host
    public let host: String
    
    /// - SeeAlso: APIClientConfiguration.generalApiPath
    public let generalAPIPath: String?
    
    /// - SeeAlso: APIClientConfiguration.defaultHeaders
    public let defaultHeaders: [String: String]
    
    /// - SeeAlso: APIClientConfiguration.printResponses
    public var printResponses: Bool
    
    /// - SeeAlso: APIClientConfiguration.printRequests
    public var printRequests: Bool
    
    // MARK: Initializer
    
    /// Initializes an instance.
    ///
    /// - Parameters:
    ///     - scheme: The scheme subcomponent of the URL.
    ///     - host: The host subcomponent of the URL.
    ///     - generalAPIPath: General API path.
    ///     - defaultHeaders: Default headers to be used in every request.
    public init(scheme: Scheme,
         host: String,
         generalAPIPath: String? = nil,
         defaultHeaders: [String: String] = ["Accept": "application/json",
                                             "Content-Type": "application/json"],
         printResponses: Bool = false,
         printRequests: Bool = false) {
        self.scheme = scheme
        self.host = host
        self.generalAPIPath = generalAPIPath
        self.defaultHeaders = defaultHeaders
        self.printResponses = printResponses
        self.printRequests = printRequests
    }
}
