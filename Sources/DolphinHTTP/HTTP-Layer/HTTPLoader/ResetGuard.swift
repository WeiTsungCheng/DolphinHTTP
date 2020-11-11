//
//  ResetGuard.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/3.
//

import Foundation

public class ResetGuard: HTTPLoader {
    
    @AtomicTransaction(wrappedValue: false, queue: DispatchQueue(label: "reset.guard.queue", qos: .background))
    private var isResetting: Bool
    
    open override func load(task: HTTPTask) {
        if isResetting == false {
            super.load(task: task)
        } else {
            task.fail(.resetInProgress)
        }
    }
    
    public override func reset(with group: DispatchGroup) {
        if isResetting == true {
            return
        }
        
        guard let next = nextLoader else { return }
        
        group.enter()
        
        _isResetting.mutate { bool in
            bool = true
        }

        next.reset {
            self._isResetting.mutate { bool in
                bool = false
            }
            group.leave()
        }
    }
}

