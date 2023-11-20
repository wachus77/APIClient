# APIClient

[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://github.com/wachus77/APIClient)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/wachus77/APIClient)
[![Swift Version: 5.5](https://img.shields.io/badge/Swift-5.5-orange.svg)](https://swift.org/)
[![macOS v12](https://img.shields.io/badge/macOS-v12-blue.svg)](https://www.apple.com/macos/)
[![iOS v15](https://img.shields.io/badge/iOS-v15-blue.svg)](https://www.apple.com/ios/)
[![tvOS v15](https://img.shields.io/badge/tvOS-v15-blue.svg)](https://www.apple.com/tvos/)
[![watchOS v8](https://img.shields.io/badge/watchOS-v8-blue.svg)](https://www.apple.com/watchos/)

APIClient is an easy-to-use HTTP client library for Swift, designed to simplify the process of making network requests. Leveraging the modern async/await pattern, it provides a more readable and efficient way to handle asynchronous calls. The library is compatible with macOS, iOS, tvOS, and watchOS, making it a versatile tool for developers working across different Apple platforms.


## Features

- **Modern Swift Concurrency**: Utilizes the async/await pattern for clean and efficient asynchronous code.
- **Easy Integration**: Accessible via Swift Package Manager.
- **Cross-Platform Compatibility**: Supports macOS v12, iOS v15, tvOS v15, and watchOS v8.
- **Swift-Friendly**: Requires a minimum of Swift 5.5.

## Installation

To integrate APIClient into your project, add the following as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/wachus77/APIClient", from: "1.0.0")
]
```

## Usage

Using APIClient is straightforward. Import the library and start making requests with ease.

```swift
import APIClient

let configuration = DefaultAPIClientConfiguration(scheme: .https, host: "test.com", generalAPIPath: "/api/v1")
let apiClient = DefaultAPIClient(configuration: configuration)

struct SomeAPIRequest: APIRequestModel {
    
    let someReqProperty: String
    
    typealias Response = SomeAPIResponse
    typealias CustomError = DefaultAPICustomError
    
    /// - SeeAlso: APIRequestModel.method
    var method: APIRequestMethod {
        return .post
    }
    
    var isRequestWithHttpBody: Bool {
        return true
    }
    
    /// - SeeAlso: APIRequestModel.path
    var path: String {
        return "/test"
    }

}

struct SomeAPIResponse: APIResponse {
    let someArray: [String]
}

struct DefaultAPICustomError: APICustomError {
    // MARK: Properties
    
    let error: String
    
    var errorDescription: String? {
        return error
    }

}

/////////
    Task {
        let someRequest = SomeAPIRequest(someReqProperty: "test")
        do {
            let someResponse = try await apiClient.request(request: someRequest)
        } catch {
            print(error.localizedDescription)
            // API error handling
            return nil
        }
    }
```

## License

APIClient is released under the MIT License. See [LICENSE](https://github.com/wachus77/APIClient/blob/main/LICENSE) for details.

## Author

Soluty Tomasz Iwaszek - iwaszek.tomasz@gmail.com

Feel free to reach out if you have any questions or suggestions!
