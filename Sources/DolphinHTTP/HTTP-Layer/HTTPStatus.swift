//
//  HTTPStatus.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

public struct HTTPStatus: Hashable {
    
    public static let success = HTTPStatus(rawValue: 200)
    public static let create = HTTPStatus(rawValue: 201)
    public static let movedPermanently = HTTPStatus(rawValue: 301)
    public static let found = HTTPStatus(rawValue: 302)
    public static let seeOther = HTTPStatus(rawValue: 303)
    public static let badRequest = HTTPStatus(rawValue: 400)
    public static let unauthorized = HTTPStatus(rawValue: 401)
    public static let forbidden = HTTPStatus(rawValue: 403)
    public static let notFound = HTTPStatus(rawValue: 404)
    public static let methodNotAllowed = HTTPStatus(rawValue: 405)
    public static let serverError = HTTPStatus(rawValue: 500)
    
    public let rawValue: Int
}

