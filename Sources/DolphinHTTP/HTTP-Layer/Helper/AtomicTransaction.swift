//
//  AtomicTransaction.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/4.
//

import Foundation

@propertyWrapper
final public class AtomicTransaction<V> {
    private let queue: DispatchQueue
    private var value: V
    
    public init(wrappedValue: V, queue: DispatchQueue) {
        self.queue = queue
        self.value = wrappedValue
    }
    
    public var wrappedValue: V {
        get { queue.sync { return value } }
        
        set { queue.async(flags: .barrier) {
            self.value = newValue
        }}
    }
    
    public func mutate(_ mutation: (inout V) -> Void) {
        return queue.sync {
            mutation(&value)
        }
    }
}
