//
//  StackRepository.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

protocol StackService {
    /**
     This *function* will return a List of stack-overflow users that has the name given as a *parameter*
     
     - Parameter word: String that contains the word that need to be searched
     - returns: Observable<PageResponseBody>
     
     */
    func getStackUsersByName(word:String) -> Observable<PageResponseBody>
}

class StackRepository:StackService{
    func getStackUsersByName(word: String) -> Observable<PageResponseBody> {
        return SearchRequest(wordSearch: word).getResponseAsObservable()
    }
}
