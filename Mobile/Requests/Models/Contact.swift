//
//  Contact.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let type: String
    let country: String
    let enumType: String
    let name: String
    let address1: String
    let address2: String
    let phones: [Phone]
    let latLong: Coordinates
    let languages: String
    let withMobileSince: String
    let canSendCcMail: Bool
    let openingHours: [OpeningHours]
    let rating: Rating
    let homepageUrl: String
    let logo: String
    let heroImage: HeroImage
    let person: Person
}

struct Phone: Codable {
    let type: String
    let number: String
    let uri: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct OpeningHours: Codable {
    let day: String
    let time: String
}

struct Rating: Codable {
    let count: Int
    let score: Float
    let scoreLocalized: String
    let link: String
    let recommendationRate: Float
    let adRealityRate: Float
}

struct HeroImage: Codable {
    let uri: String
    let set: String
}

struct Person: Codable {
    let name: String
    let logo: String
    let role: String
}
