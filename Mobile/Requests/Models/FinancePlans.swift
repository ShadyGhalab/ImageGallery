//
//  FinancePlans.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation

struct FinancePlans: Codable {
    let type: String
    let budgetStatus: String
    let fallback: Bool
    let url: String
    let bankLogoUri: String
    let bankId: String?
    let downPayment: Int
    let loanDuration: Int
    let netAmount: Int
    let monthlyRate: Double
    let interestRateEffective: Float
    let disclaimer: String
    let localized: LocalizedFinancePlans
}

struct LocalizedFinancePlans: Codable {
    let amount: String
    let netAmount: String
    let downPayment: String
    let monthlyRate: String
    let interestRateEffective: String
}
