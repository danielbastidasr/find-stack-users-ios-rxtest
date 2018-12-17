//
//  StackOverflowUsersTests.swift
//  StackOverflowUsersTests
//
//  Created by Daniel Bastidas Ramirez on 14/12/2018.
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import StackOverflowUsers

class StackOverflowUsersTests: XCTestCase {
    
    private var disposeBag:DisposeBag!
    private var scheduler:TestScheduler!
    private var testObserver:TestableObserver<[StackUser]>!
    
    override func setUp() {
        //This method is called before the invocation of each test method in the class.
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        testObserver = scheduler.createObserver([StackUser].self)
    }

    func testStackUsersViewModelWithConnection() {
        
        // GIVEN Request Success with Users
        let users = [StackUser(name: "Daniel"),StackUser(name: "Jorge"),StackUser(name: "Alina")]
        let viewModel = StackUsersViewModel(stackUsers:  GetUsers(stackRep: MockRequestSuccessUsers()))
        
        // WHEN View Model Initialises and Typed any word
        initialiseViewModelOutputs(viewModel: viewModel)
        viewModel.searchText.onNext("AnyWord")
        
        // THEN Receive in the View All the users to be displayed
        let expectedEvents = [
            next(0,users)
        ]
        XCTAssertEqual(expectedEvents, testObserver.events)
    }
    
    func testStackUsersViewModelWithConnectionError() {
        
        // GIVEN Request With Error
        let viewModel = StackUsersViewModel(stackUsers:  GetUsers(stackRep: MockRequestFailed()))
        
        // WHEN View Model Initialises and Typed any word
        initialiseViewModelOutputs(viewModel: viewModel)
        viewModel.searchText.onNext("AnyWord")
        
        // THEN Receive a Empty Array
        let expectedEvents: [Recorded<Event<[StackUser]>>] = [
            next(0,[])
        ]
        XCTAssertEqual(expectedEvents, testObserver.events)
    }

}

// MARK:- Helper functions
extension StackOverflowUsersTests{
    
    private func initialiseViewModelOutputs(viewModel:StackUsersViewModeling){
        viewModel.initialise()
        viewModel.cellModels
            .map({ (stackCells) -> [StackUser] in
                var users:[StackUser] = []
                
                stackCells.forEach({ (cell) in
                    users.append(cell.stackUser)
                })
                return users
            })
            .subscribe(testObserver)
            .disposed(by: disposeBag)
    }
}

// MARK:- MOCK CLASSES
class MockRequestSuccessUsers: StackService {
    func getStackUsersByName(word: String) -> Observable<PageResponseBody> {
        let users = [StackUser(name: "Daniel"),StackUser(name: "Jorge"),StackUser(name: "Alina")]
        return Observable.just(PageResponseBody(items: users))
    }
}

class MockRequestFailed: StackService {
    func getStackUsersByName(word: String) -> Observable<PageResponseBody> {
        return Observable.error(NSError(domain: "My Error", code: -1, userInfo: nil))
    }
}
