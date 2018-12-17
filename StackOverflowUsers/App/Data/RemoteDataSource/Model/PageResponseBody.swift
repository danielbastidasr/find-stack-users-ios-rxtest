//
//  PageResponseBody.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation

class PageResponseBody: Decodable {
    var items:[StackUser]
    
    init(items:[StackUser]) {
        self.items = items
    }
}
