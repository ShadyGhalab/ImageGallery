//
//  Price.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation

struct Price: Codable {
    let grs: PriceType
    let nt: PriceType // swiftlint:disable:this identifier_name
    let type: String
    let vat: Float
}

struct PriceType: Codable {
    let amount: Float
    let currency: String
    let localized: String
}
