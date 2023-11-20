//
//  APIError.swift
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

import Foundation

public enum APIError: CustomNSError, LocalizedError {
    case urlRequestCreationFailed
    case conversionToHTTPURLResponseFailed
    // Fall under 400..499
    case badRequest(errorCode: Int, customError: Error? = nil, String? = "Invalid request") // 400 --> bad request
    case unAuthorised(errorCode: Int, customError: Error? = nil, String? = "Unautorised request") // 401 --> UnAutorised
    case notFound(errorCode: Int, customError: Error? = nil, String? = "Data not found") // 404 --> Data not found
    case invalidResponse(errorCode: Int, customError: Error? = nil, String? = "Invalid response") // 406 --> Not Acceptable response
    case conflictError(errorCode: Int, customError: Error? = nil, String? = "Already exist") // 409 --> Conflict
    
    // 500 & above
    case serverError(errorCode: Int, customError: Error? = nil, String? = "Services are down")
    
    // Some Error
    case some(errorCode: Int, customError: Error? = nil, String? = "Some error occured")
    
    public var errorCode: Int {
        switch self {
        case
            let .badRequest(code, _, _),
            let .unAuthorised(code, _, _),
            let .notFound(code, _, _),
            let .invalidResponse(code, _, _),
            let .conflictError(code, _, _),
            let .serverError(code, _, _),
            let .some(code, _, _):
            return code
        case .urlRequestCreationFailed:
            return -1001
        case .conversionToHTTPURLResponseFailed:
            return -1002
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case
            let .badRequest(_, underlyingError, errorMessage),
            let .unAuthorised(_, underlyingError, errorMessage),
            let .notFound(_, underlyingError, errorMessage),
            let .invalidResponse(_, underlyingError, errorMessage),
            let .conflictError(_, underlyingError, errorMessage),
            let .serverError(_, underlyingError, errorMessage),
            let .some(_, underlyingError, errorMessage):
            return underlyingError?.localizedDescription ?? errorMessage
        case .urlRequestCreationFailed:
            return "urlRequestCreationFailed"
        case .conversionToHTTPURLResponseFailed:
            return "conversionToHTTPURLResponseFailed"
        }
    }
    
    public var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: errorDescription ?? ""]
    }
}
