//
//  GetStackUsersUseCase.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

protocol  GetStackUsersUseCase {
    /**
     This *function* will return a List of users that has the name given as a *parameter*
     
     - Parameter name: String that contains the word that need to be searched
     - returns: Observable<[StackUser]>
     
     */
    func getUsersByName(with name:String) -> Observable<[StackUser]>
}

class GetUsers: GetStackUsersUseCase {
    private var stackRep: StackService
    
    init(stackRep:StackService) {
        self.stackRep = stackRep
    }
    
    func getUsersByName(with name: String) -> Observable<[StackUser]> {
        // This could be more complex.
        // dependency with other usecases or more repositories (LoginRepository,..etc)
        return stackRep.getStackUsersByName(word: name)
            .map({ (pageResponse) -> [StackUser] in
                return pageResponse.items
            })
    }
}
