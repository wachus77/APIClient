//
//  APIResponse.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

/// An API response representation that can be just decodable.
public protocol APIResponse: Decodable {
    /// A decoder to be used when decoding a response.
    static var decoder: JSONDecoder { get }
}

extension APIResponse {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}


