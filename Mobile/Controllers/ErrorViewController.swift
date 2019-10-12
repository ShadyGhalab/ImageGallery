//
//  ErrorViewController.swift
//  Mobile
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController, StoryboardMakeable {
    
    static var storyboardName: String = "Loading"
    typealias StoryboardMakeableType = ErrorViewController
    
    let viewModel: ErrorViewProtocol = ErrorViewModel()
    
    @IBOutlet private weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outputs.errorMessage
            .observeValues { [unowned self] errorMessage in
                self.errorLabel.text = errorMessage
        }
    }
}
