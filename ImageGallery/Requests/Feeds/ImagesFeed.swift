//
//  ImagesFeed.swift
//
//  Created by Shady Mustafa on 16.07.19.

//

import Foundation

struct ImagesFeed: Feed {
    let absolutePath: String
    var parameters: [String: Any]? { return nil }
    
    init(absolutePath: String) {
        self.absolutePath = absolutePath
    }
    
    func unwrapModel(_ jsonDecodingResult: UniversalItem) -> DataWrapper<ImageModel>? {
        return  DataWrapper(data: jsonDecodingResult.images)
    }
}

struct DataWrapper<T: Codable> {
    let data: [T]
}
