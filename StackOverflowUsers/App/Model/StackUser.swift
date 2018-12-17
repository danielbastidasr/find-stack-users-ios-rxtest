//
//  StackUser.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation

class StackUser : Equatable, Decodable {
    var name:String
    
    init(name:String) {
        self.name = name
    }
    
    static func == (lhs: StackUser, rhs: StackUser) -> Bool {
        return lhs.name == rhs.name
    }
    
    private enum CodingKeys : String, CodingKey {
        case name = "display_name"
    }
}
