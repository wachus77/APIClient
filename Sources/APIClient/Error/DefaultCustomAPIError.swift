//
//  DefaultCustomAPIError.swift
//  
//
//  Created by Iwaszek, Tomasz on 20/11/2023.
//

public struct DefaultCustomAPIError: APICustomError {
    // MARK: Properties
    
    let errorMessage: String
    
    public var errorDescription: String? {
        return errorMessage
    }
}
