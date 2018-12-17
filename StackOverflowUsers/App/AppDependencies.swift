//
//  AppDependencies.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation
import Swinject

let container = Container() { container in
    
    // Models
    container.register(StackService.self) { _ in
        StackRepository()
    }
    
    //Repositories
    container.register(GetStackUsersUseCase.self) { r in
        GetUsers(stackRep: r.resolve(StackService.self)!)
    }
    
    // ViewModels
    container.register(StackUsersViewModeling.self) { r in
        StackUsersViewModel(stackUsers: r.resolve(GetStackUsersUseCase.self)!)
    }
    
    // Views
    container.storyboardInitCompleted(StackListViewController.self) { r,c in
        c.viewModel = r.resolve(StackUsersViewModeling.self)
    }
}
