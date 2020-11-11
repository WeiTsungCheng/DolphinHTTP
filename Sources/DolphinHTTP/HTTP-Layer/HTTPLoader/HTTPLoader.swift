//
//  HTTPLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/27.
//

import Foundation

open class HTTPLoader {
    
    public var nextLoader: HTTPLoader? {
        
        willSet {
            guard nextLoader == nil else { fatalError("The nextLoader may only be set once") }
        }
    }
    
    public init() { }
    
    open func load(task: HTTPTask) {
        if let next = nextLoader {
            next.load(task: task)
        } else {
            task.fail(.cannotConnect)
        }
    }
    
    open func reset(with group: DispatchGroup) {
        nextLoader?.reset(with: group)
    }
    
}

extension HTTPLoader {
    
    public final func reset(on queue: DispatchQueue = .main, completionHandler: @escaping ()-> Void) {
        let group = DispatchGroup()
        self.reset(with: group)
        
        group.notify(queue: queue, execute: completionHandler)
    }
    
    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        let task = HTTPTask(request: request, completion: completion)
        
        load(task: task)
    }

}

