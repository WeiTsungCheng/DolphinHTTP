//
//  MockLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/28.
//

import Foundation

public class MockLoader: HTTPLoader {
    
    public typealias HTTPHandler = (HTTPResult) -> Void
    public typealias MockHandler = (HTTPRequest, HTTPHandler) -> Void
    
    public var nextHandlers = Array<MockHandler>()
    
    open override func load(task: HTTPTask) {
        if nextHandlers.isEmpty == false {
            let next = nextHandlers.removeFirst()
            next(task.request, task.completion)
        } else {
            task.fail(.cannotConnect)
        }
    }
    
    @discardableResult
    public func then(_ handler: @escaping MockHandler) -> MockLoader {
        nextHandlers.append(handler)
        return self
    }
}




