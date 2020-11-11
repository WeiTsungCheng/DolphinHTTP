//
//  ThreadSafeArray.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/6.
//

import Foundation

public class ThreadSafeArray<Element> {
    
    private var array: Array<Element>
    private let queue = DispatchQueue(label: "theard.safe.array.queue", attributes: .concurrent)
    
    public init() {
        array = Array<Element>()
    }
    
    public init(array: Array<Element>) {
        self.array = array
    }
}

extension ThreadSafeArray {
    
    public subscript(index: Int) -> Element {
        get {
            self.queue.sync {
                return array[index]
            }
        }
        set {
            self.queue.async(flags: .barrier) {
                self.array[index] = newValue
            }
        }
    }
    
    var first: Element? {
        self.queue.sync {
            return array.first
        }
    }
    
    var last: Element? {
        self.queue.sync {
            return array.last
        }
    }
    
    var count: Int {
        self.queue.sync {
            return array.count
        }
    }
    
    var values: Array<Element> {
        self.queue.sync {
            return array
        }
    }
    
    func reversed() -> Array<Element> {
        self.queue.sync {
            return self.array.reversed()
        }
    }
    
    func append(_ newElement: Element) {
        self.queue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
    
    func remove(at index: Int) -> Element? {
        var element: Element?
        self.queue.sync {
            if self.array.startIndex ..< self.array.endIndex ~= index {
                element = self.array.remove(at: index)
            } else {
                element = nil
            }
        }
        return element
    }
}


