//
//  File.swift
//  
//
//  Created by WEI-TSUNG CHENG on 2020/11/11.
//

import Foundation
import DolphinHTTP

class TestAPI {
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader) {
        self.loader = loader
    }
    
    func getTestUsers(completion: @escaping(([TestUser]) -> Void)) {
        var r = HTTPRequest()
        r.path = "/ex/users.json"
        r.host = "learnappmaking.com"
        loader.load(request: r) { (result) in
            let users = try! JSONDecoder().decode([TestUser].self, from: (result.response?.body)!)
            completion(users)
        }
    }
}

