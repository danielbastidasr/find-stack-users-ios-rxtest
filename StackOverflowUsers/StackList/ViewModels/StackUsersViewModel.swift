//
//  StackUsersViewModel.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

protocol StackUsersViewModeling {
    // MARK: - Input
    var cellDidSelect: PublishSubject<Int> { get }
    var searchText: PublishSubject<String> { get }
    
    // MARK: -
    func initialise()
    
    // MARK: - Output
    var cellModels: Observable<[StackUserCellViewModeling]> { get }
    var userSelected: Observable<StackUser> { get }
}

class StackUsersViewModel: StackUsersViewModeling {
    
    // MARK: - Input
    var cellDidSelect: PublishSubject<Int> = PublishSubject<Int>()
    var searchText: PublishSubject<String> = PublishSubject<String>()
    
    // MARK: - Output
    var cellModels: Observable<[StackUserCellViewModeling]> = Observable.never()
    var userSelected: Observable<StackUser> = Observable.never()
    
    private var stackUsers:GetStackUsersUseCase
    
    init(stackUsers:GetStackUsersUseCase) {
        self.stackUsers = stackUsers
    }
    
    func initialise() {
        
        cellModels = searchText.flatMap {[unowned self] (wordSearch) -> Observable<[StackUserCellViewModeling]> in
            
            if(wordSearch != ""){
                return self.stackUsers.getUsersByName(with: wordSearch).map {
                    (users) -> [StackUserCellViewModeling] in
                        var cells:[StackUserCellViewModeling] = []
                    
                        users.forEach({ (user) in
                            cells.append(StackUserCellViewModel(stackUser: user))
                        })
                        return cells
                    }
                    .catchError({ (error) -> Observable<[StackUserCellViewModeling]> in
                        return Observable.just([])
                    })
            }
            return Observable.just([])
            
        }
    }
}
