//
//  HTTPBody.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/27.
//

import Foundation

public protocol HTTPBody {
    
    var isEmpty: Bool { get }
    var additionalHeaders: [String: String] { get }
    
    func encode() throws -> Data
}

extension HTTPBody {
    
    public var isEmpty: Bool { return false }
    public var additionalHeaders: [String: String] { return [:] }
}

public struct EmptyBody: HTTPBody {
    
    public let isEmpty: Bool = true
    
    public init() {}
    
    public func encode() throws -> Data { return Data()}
}

public struct DataBody: HTTPBody {
    
    private let data: Data
    public var isEmpty: Bool { return data.isEmpty }
    public var additionalHeaders: [String : String]
    
    public init(_ data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }
    
    public func encode() throws -> Data { data }
}

public struct JSONBody: HTTPBody {
    
    public let isEmpty: Bool = false
    public var additionalHeaders: [String : String] = [
        "Content-Type": "application/json; charset=utf-8"
    ]

    private let encodeData: () throws -> Data

    public init<T: Encodable>(_ value: T, encoder: JSONEncoder = JSONEncoder()) {
        self.encodeData = { try encoder.encode(value) }
    }

    public func encode() throws -> Data { return try encodeData() }
}


public struct FormBody: HTTPBody {
    
    public var isEmpty: Bool { values.isEmpty }
    public let additionalHeaders: [String : String] = [
        "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    ]
    private let values: [URLQueryItem]
    
    public init(_ values: [URLQueryItem]) {
        self.values = values
    }
    
    public init(_ values: [String: String]) {
        let queryItems = values.map { URLQueryItem(name: $0.key, value: $0.value) }
        self.init(queryItems)
    }
    
    public func encode() throws -> Data {
        let pieces = values.map(self.urlEncode)
        let bodyString = pieces.joined(separator: "&")
        return Data(bodyString.utf8)
    }
    
    
    private func urlEncode(_ queryItem: URLQueryItem) -> String {
        let name = urlEncode(queryItem.name)
        let value = urlEncode(queryItem.value ?? "")
        return "\(name)=\(value)"
    }
    
    private func urlEncode(_ string: String) -> String {
        let allowedCharacters = CharacterSet.alphanumerics
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
    }
}



