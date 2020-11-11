//
//  AutoCancel.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/6.
//

import Foundation

public class AutoCancel: HTTPLoader {
    
    private let queue = DispatchQueue(label: "auto.cancel.loader.queue")
    private var currentTasks = [UUID : HTTPTask]()
    
    public override func load(task: HTTPTask) {
        queue.sync {
            let id = task.id
            currentTasks[id] = task
            task.addCompletionHandler {
                self.queue.sync {
                   self.currentTasks[id] = nil
                }
            }
        }
        super.load(task: task)
    }
    
    public override func reset(with group: DispatchGroup) {
        group.enter()
        queue.async {
            let copy = self.currentTasks
            self.currentTasks = [:]
            DispatchQueue.global(qos: .userInitiated).async {
                for task in copy.values {
                    task.cancel()
                }
                group.leave()
            }
        }
        nextLoader?.reset(with: group)
    }
}
