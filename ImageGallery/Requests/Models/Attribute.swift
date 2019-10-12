//
//  Attribute.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation

struct Attribute {
    let label: String?
    let tag: String?
    let value: [String]?
    
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case tag = "tag"
        case value = "value"
    }
}

extension Attribute: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(tag, forKey: .tag)
        try container.encodeIfPresent(value, forKey: .value)
    }
}

extension Attribute: Decodable {
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        
        if let value = try? values.decodeIfPresent(String.self, forKey: .value) {
            self.value = [value]
        } else if let value = try? values.decodeIfPresent([String].self, forKey: .value) {
            self.value = value
        } else {
            value = nil
        }
    }
}
