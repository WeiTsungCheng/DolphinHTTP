//
//  PrintLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public class PrintLoader: HTTPLoader {
    
    open override func load(task: HTTPTask) {
        let completion = task.completion
        task.completion = { result in
            print("""
                -------------------
                ⛳️ Result:
                \(result)
                -------------------
                """)
            completion(result)
        }
    
        super.load(task: task)
    }
    
    public override func reset(with group: DispatchGroup) {
        super.reset(with: group)
    }
}

