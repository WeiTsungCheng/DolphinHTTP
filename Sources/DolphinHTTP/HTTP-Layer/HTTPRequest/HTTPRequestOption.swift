//
//  HTTPRequestOption.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/2.
//

import Foundation

public protocol HTTPRequestOption {
    
    associatedtype Value
    static var defaultOptionValue: Value { get }
}
