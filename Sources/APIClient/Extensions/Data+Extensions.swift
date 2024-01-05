//
//  Data+Extensions.swift
//  
//
//  Created by Tomasz Iwaszek on 05/01/2024.
//

import Foundation

extension Data: APIResponse {}

extension Data {
    mutating func append(_ string: String) {
        self.append(string.data(using: .utf8, allowLossyConversion: true)!)
    }
}
