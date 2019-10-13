//
//  DataResponseDecoder.swift
//
//  Created by Shady Mustafa on 16.07.19.

//

import Foundation
import ReactiveSwift

enum DataResponseDecodeError: Error {
    case decodeToModelFailed
    case decodeToJsonFailed
}

public protocol DataResponseDecoding {
    func decodeModel<F: Feed>(from data: Data, fetchedFrom feed: F) throws -> F.Model
    func decodeModel<F: Feed>(from json: [String: Any], fetchedFrom feed: F) throws -> F.Model where F.Model: Decodable
    func decodeJson(from data: Data) throws -> [String: Any]
}

public struct DataResponseDecoder: DataResponseDecoding {
    public init() {}
    
    public func decodeModel<F: Feed>(from data: Data, fetchedFrom feed: F) throws -> F.Model {
        let decoder = JSONDecoder.makeDecoder(with: feed.customDateFormat)
        let jsonResultModel = try decoder.decode(F.JSONResponseStructure.self, from: data)
        if let model = feed.unwrapModel(jsonResultModel) {
            return model
        } else {
            throw DataResponseDecodeError.decodeToModelFailed
        }
    }
    
    public func decodeModel<F: Feed>(from json: [String: Any], fetchedFrom feed: F) throws -> F.Model {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try decodeModel(from: data, fetchedFrom: feed)
    }
    
    public func decodeJson(from data: Data) throws -> [String: Any] {
        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        guard let jsonDict = json as? [String: Any] else {
            throw DataResponseDecodeError.decodeToJsonFailed
        }
        return jsonDict
    }
}

public extension JSONDecoder {
    static func makeDecoder(with customDateFormat: String?) -> JSONDecoder {
        guard let customDateFormat = customDateFormat else { return JSONDecoder() }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = customDateFormat
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}
