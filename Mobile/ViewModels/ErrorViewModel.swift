//
//  ErrorViewModel.swift
//  Mobile
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ErrorViewInputs {
    func configure(withError error: String)
}

protocol ErrorViewOutputs {
    var errorMessage: Signal<String, Never> { get }
}

protocol ErrorViewProtocol: Any {
    var inputs: ErrorViewInputs { get }
    var outputs: ErrorViewOutputs { get }
}

struct ErrorViewModel: ErrorViewInputs, ErrorViewOutputs, ErrorViewProtocol {
    
    var inputs: ErrorViewInputs { return self }
    var outputs: ErrorViewOutputs { return self }
   
    init() {
        errorMessage = errorProperty.signal
    }
    
    private let errorProperty = MutableProperty<String>("")
    func configure(withError error: String) {
        errorProperty.value = error
    }
    
    let errorMessage: Signal<String, Never>
}
