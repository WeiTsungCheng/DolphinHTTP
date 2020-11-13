//
//  HTTPError.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import Foundation

public struct HTTPError: Error {
    
    public let code: Code
    public let request: HTTPRequest
    public let response: HTTPResponse?
    public let underlyingError: Error?
    
    public init(code: Code, request: HTTPRequest, response: HTTPResponse?, underlyingError: Error?) {
        self.code = code
        self.request = request
        self.response = response
        self.underlyingError = underlyingError
    }
    
    public enum Code {
        case invalidRequest
        case cannotConnect
        case cancelled
        case insecureConnection
        case invalidResponse
        case resetInProgress
        case unknown
    }
}
