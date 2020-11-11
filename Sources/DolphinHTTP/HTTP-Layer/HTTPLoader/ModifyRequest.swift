//
//  ModifyRequest.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public class ModifyRequest: HTTPLoader {
    
    private let modifier: (HTTPRequest) -> HTTPRequest
    
    public init(modifier: @escaping (HTTPRequest) -> HTTPRequest) {
        self.modifier = modifier
        super.init()
    }
    
    open override func load(task: HTTPTask) {
        let modifiedRequest = modifier(task.request)
        task.request = modifiedRequest
        super.load(task: task)
    }

}
