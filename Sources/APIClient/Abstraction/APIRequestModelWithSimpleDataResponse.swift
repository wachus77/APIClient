//
//  APIRequestModelWithSimpleDataResponse.swift
//
//
//  Created by Tomasz Iwaszek on 05/01/2024.
//

import Foundation

public protocol APIRequestModelWithSimpleDataResponse: APIRequestModel where Response == Data {}
