//
//  FinanceBudget.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation

struct FinanceBudget: Codable {
    let netIncome: Int
    let downPayment: Int
    let loanDuration: Int
    let budgetStatus: String
    let localized: LocalizedFinanceBudget
}

struct LocalizedFinanceBudget: Codable {
    let netIncome: String
    let downPayment: String
}
