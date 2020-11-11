//
//  HTTPTask.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/4.
//

import Foundation

public class HTTPTask {
    
    public var id: UUID { request.id }
    public var request: HTTPRequest
    public var completion: (HTTPResult) -> Void
    
    private let taskCancelQueue: DispatchQueue = DispatchQueue(label: "task.cancel.queue", attributes: .concurrent)
    private var cancellationHandlers = Array<(() -> Void)>()
    
    private let taskCompleteQueue: DispatchQueue = DispatchQueue(label: "task.complete.queue", attributes: .concurrent)
    private var completionHandlers = Array<(() -> Void)>()
    
    public init(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        self.request = request
        self.completion = completion
    }
    
    public func addCancellationHandler(_ handler: @escaping () -> Void) {
        
        taskCancelQueue.async(flags: .barrier) { [weak self] in
            self?.cancellationHandlers.append(handler)
        }
    }
    
    public func addCompletionHandler(_ handler: @escaping () -> Void) {
        
        taskCompleteQueue.async(flags: .barrier)  { [weak self] in
            self?.completionHandlers.append(handler)
        }
    }
    
    public func cancel() {
        
        taskCancelQueue.async(flags: .barrier) { [weak self] in
            let handlers = self?.cancellationHandlers
            handlers?.reversed().forEach { $0() }
            self?.cancellationHandlers = Array<(() -> Void)>()
        }
    }
    
    public func complete(with result: HTTPResult) {
        
        taskCompleteQueue.async(flags: .barrier) { [weak self] in
            let handlers = self?.completionHandlers
            handlers?.reversed().forEach { $0() }
            self?.completionHandlers = Array<(() -> Void)>()
        }
        
        completion(result)
    }
    
    public func fail(_ code: HTTPError.Code, response: HTTPResponse? = nil, underlyingError: Error? = nil) {
        
        taskCompleteQueue.async(flags: .barrier) { [weak self] in
            let handlers = self?.completionHandlers
            handlers?.reversed().forEach { $0() }
            self?.completionHandlers = Array<(() -> Void)>()
        }
        
        let error = HTTPError(code: code, request: request, response: response, underlyingError: underlyingError)
        
        completion(.failure(error))
    }
}
