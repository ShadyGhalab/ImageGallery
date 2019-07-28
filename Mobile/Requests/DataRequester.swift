//
//  DataRequester.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation
import ReactiveSwift
import os.log

struct DataRequester {
    
    private let urlSession = URLSession(configuration: .default)

    public func requestData<F>(from feed: F) -> SignalProducer<Data, FetchError> where F: Feed {
        let absolutePath = feed.absolutePath
        
        return SignalProducer<Data, FetchError> { observer, _ in
            os_log("requesting Model %@ from %@ with override parameters: %@)",
                   log: .requestsLogger, type: .debug, "\(F.Model.self)", absolutePath, feed.parameters ?? [:])
            
            guard let request = self.urlRequest(with: absolutePath, parameters: feed.parameters) else { return observer.send(error: .nonFatal) }
            
            let dataTask = self.urlSession.dataTask(with: request, completionHandler: { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    observer.send(error: .httpError(statusCode: httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    os_log("Error getting data from %@", log: .requestsLogger, type: .error, "\(F.self)")
                    observer.send(error: .noContentReturned)
                    return
                }
                
                observer.send(value: data)
                observer.sendCompleted()
            })
            
            dataTask.resume()
        }
    }
    
    private func urlRequest(with path: String, parameters: [String: Any]?) -> URLRequest? {
        var urlComponents = URLComponents(string: path)
        urlComponents?.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
        if let url = urlComponents?.url {
            return URLRequest(url: url)
        }
        
        os_log("malformed url from path %@", log: .requestsLogger, type: .error, path)
     
        return nil
    }
}
