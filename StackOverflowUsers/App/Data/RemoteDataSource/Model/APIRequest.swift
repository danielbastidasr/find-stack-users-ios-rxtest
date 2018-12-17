//
//  APIRequest.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import Foundation
import RxSwift

public enum RequestType: String {
    case GET, POST
}

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func request() -> URLRequest {
        
        let baseURL = getBaseUrl()
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    // MARK:- Here you can have streams of data, register different response codes (2XX-3XX , 4XX,...etc.)
    func getResponseAsObservable<T: Decodable>() -> Observable<T> {
        
        return Observable<T>.create { observer in
        
            let task = URLSession.shared.dataTask(with:self.request()) { (data, response, error) in
                if (error != nil) {
                    observer.onError(NSError(domain: "APIRequest", code: -1, userInfo: nil))
                    return
                }
                if(data != nil){
                    do {
                        let model: T = try JSONDecoder().decode(T.self, from: data!)
                        observer.onNext(model)
                    } catch let jsonErr {
                        print(jsonErr)
                        observer.onError(NSError(domain: "APIRequest", code: -1, userInfo: nil))
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    // MARK:- Could create getResponseAsJson or gerResponseAsList of T
    
    private func getBaseUrl() -> URL {
        return URL(string: "https://api.stackexchange.com/2.2/")!
    }
}
