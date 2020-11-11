//
//  ServerEnvironment.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public struct ServerEnvironment: HTTPRequestOption {
    
    public var host: String
    public var pathPrefix: String
    public var headers: [String: String]
    public var query: [URLQueryItem]
    public static var defaultOptionValue: ServerEnvironment? = nil
    
    public init(host: String, pathPrefix: String = "/", headers: [String: String] = [:], query: [URLQueryItem] = []) {
        let prefix = pathPrefix.hasPrefix("/") ? "" : "/"
        self.host = host
        self.pathPrefix = prefix + pathPrefix
        self.headers = headers
        self.query = query
    }
}
