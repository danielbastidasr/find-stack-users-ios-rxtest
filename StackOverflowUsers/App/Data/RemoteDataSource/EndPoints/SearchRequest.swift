//
//  SearchRequest.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation

class SearchRequest: APIRequest {
    var method = RequestType.GET
    var path = "users"
    var parameters = [String: String]()
    
    init(wordSearch: String) {
        parameters["inname"] = wordSearch
        parameters["site"] = "stackoverflow"
    }
}
