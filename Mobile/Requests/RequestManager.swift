//
//  RequestManager.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation
import os.log
import ReactiveSwift

public enum FetchError: Error {
    case noContentReturned
    case httpError(statusCode: Int)
    case nonFatal
    case fatal
}

public protocol CanRequestFeeds {
    func request<F: Feed>(from feed: F) -> SignalProducer<F.Model, FetchError>
}

public struct RequestManager: CanRequestFeeds {
    
    private let urlSession = URLSession(configuration: .default)
    
    private let dataRequester: DataRequester
    private let responseDecoder: DataResponseDecoding = DataResponseDecoder()
    
    init(dataRequester: DataRequester = DataRequester()) {
        self.dataRequester = dataRequester
    }
    
    public func request<F: Feed>(from feed: F) -> SignalProducer<F.Model, FetchError> {
        return dataRequester.requestData(from: feed)
            .attemptMap { data in
                do {
                    let model = try self.responseDecoder.decodeModel(from: data, fetchedFrom: feed)
                    return .success(model)
                } catch {
                    self.logDecodeError(error, from: feed)
                    return .failure(.noContentReturned)
                }
        }
    }
    
    private func logDecodeError<F: Feed>(_ error: Error, from feed: F) {
        switch error {
        case DataResponseDecodeError.decodeToModelFailed:
            let type = "\(F.Model.self)"
            os_log("Error trying to unwrap model: %@", log: .requestsLogger, type: .error, type)
            os_log("URL was: %@", log: .requestsLogger, type: .error, feed.absolutePath)
        default:
            let type = "\(F.JSONResponseStructure.self)"
            os_log("Error trying to decode %@: %@", log: .requestsLogger, type: .error, type, error.localizedDescription)
            os_log("URL was: %@", log: .requestsLogger, type: .error, feed.absolutePath)
        }
    }
}
