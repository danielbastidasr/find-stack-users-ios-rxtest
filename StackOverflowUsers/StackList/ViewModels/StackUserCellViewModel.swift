//
//  StackUserCellViewModel.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation

protocol StackUserCellViewModeling {
    // MARK: - Output
    var stackUser: StackUser { get }
}

class StackUserCellViewModel: StackUserCellViewModeling {
    var stackUser: StackUser
    
    init(stackUser:StackUser) {
        self.stackUser = stackUser
    }
}
