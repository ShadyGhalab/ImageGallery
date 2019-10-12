//
//  UniversalItemFeed.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation

struct UniversalItemFeed: Feed {
    let absolutePath: String
    var parameters: [String: Any]? { return nil }
    
    init(absolutePath: String) {
        self.absolutePath = absolutePath
    }
    
    func unwrapModel(_ jsonDecodingResult: UniversalItem) -> UniversalItem? {
        return jsonDecodingResult
    }
}
