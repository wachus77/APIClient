//
//  APICustomError.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

public protocol APICustomError: Decodable, LocalizedError {
    /// A decoder to be used when decoding an error.
    static var decoder: JSONDecoder { get }
}

extension APICustomError {
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}

