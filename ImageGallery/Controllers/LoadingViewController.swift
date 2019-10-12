//
//  LoadingViewController.swift
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit
import ReactiveSwift

fileprivate enum Constants {
    static let showImageGallery = "showImageGallery"
}

final class LoadingViewController: UIViewController, StoryboardMakeable {
   
    static var storyboardName: String = "Loading"
    typealias StoryboardMakeableType = LoadingViewController
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorContainer: UIView!
    
    let viewModel: LoadingViewProtocol = LoadingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()

        viewModel.inputs.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.outputs.finishedLoading
            .observe(on: UIScheduler())
            .observeValues { [unowned self] _ in
                self.loadingIndicator.stopAnimating()
        }
        
        viewModel.outputs.images
            .observe(on: UIScheduler())
            .observeValues { [unowned self] images in
                self.performSegue(withIdentifier: Constants.showImageGallery, sender: images)
        }
        
        viewModel.outputs.errorMessage
            .observe(on: UIScheduler())
            .observeValues { [unowned self] error in
                self.embedErrorViewController(withError: error)
        }
    }
    
    private func embedErrorViewController(withError error: String) {
        let errorViewController = ErrorViewController.make()
        embed(errorViewController, in: errorContainer)
        errorViewController.viewModel.inputs.configure(withError: error)
    }
}

extension LoadingViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showImageGallery,
            let navigationController = segue.destination as? UINavigationController,
            let viewController = navigationController.topViewController as? ImageGalleryViewController,
            let imageModels = sender as? [ImageModel] {
            
            viewController.viewModel.inputs.configure(with: imageModels, imageProvider: ImageGalleryProvider())
        }
    }
}
