//
//  Feed.swift
//
//  Created by Shady Mustafa on 16.07.19.

//

import Foundation

public protocol Feed {
    associatedtype JSONResponseStructure: Codable
    associatedtype Model
    
    var absolutePath: String { get }
    var parameters: [String: Any]? { get }
    var customDateFormat: String? { get }
    
    func unwrapModel(_ jsonDecodingResult: JSONResponseStructure) -> Model?
}

extension Feed {
    public var customDateFormat: String? { return nil }
}
