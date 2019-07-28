//
//  UniversalItem.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation

struct UniversalItem: Codable {
    let isOnStock: Bool
    let attributes: [Attribute]
    let customDimensions: [String: String]
    let mediaGallery: MediaGallery
    let financeBudget: FinanceBudget
    let htmlDescription: String
    let makeKey: String
    let modelKey: String
    let isNew: Bool
    let hasEnvkv: Bool
    let isFinancingFeature: Bool
    let isVideoEnabled: Bool
    let isConditionNew: Bool
    let contact: Contact
    let created: Double
    let modified: Double
    let renewed: Double
    let version: Int
    let makeId: Int
    let modelId: Int
    let financePlans: [FinancePlans]
    let links: [Link]
    let images: [ImageModel]
    let features: [String]
    let sellerId: Double
    let segment: String
    let title: String
    let url: String
    let vat: String
    let vc: String // swiftlint:disable:this identifier_name
    let id: Double
}
