//
//  LoaderChainingPrecedence.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

precedencegroup LoaderChainingPrecedence {
    higherThan: NilCoalescingPrecedence
    associativity: right
}

infix operator --> : LoaderChainingPrecedence

@discardableResult
public func --> (lhs: HTTPLoader, rhs: HTTPLoader) -> HTTPLoader {
    lhs.nextLoader = rhs
    return lhs
}
