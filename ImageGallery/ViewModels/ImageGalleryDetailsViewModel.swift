//
//  ImageGalleryDetailsViewController.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit.UIImage

protocol ImageGalleryDetailsViewInputs {
    func configure(with imageProvider: ImageProvider, withUri uri: String)
    func viewDidLoad()
}

protocol ImageGalleryDetailsViewOutputs {
    var image: Signal<UIImage, Never> { get }
}

protocol ImageGalleryDetailsViewProtocol: Any {
    var inputs: ImageGalleryDetailsViewInputs { get }
    var outputs: ImageGalleryDetailsViewOutputs { get }
}

struct ImageGalleryDetailsViewModel: ImageGalleryDetailsViewInputs, ImageGalleryDetailsViewOutputs, ImageGalleryDetailsViewProtocol {
   
    var inputs: ImageGalleryDetailsViewInputs { return self }
    var outputs: ImageGalleryDetailsViewOutputs { return self }
    
    init(imagePlaceholder: UIImage = UIColor.white.image()) {
        
        let imageModelsWithUri = imageProviderProperty.signal
            .skipNil()
            .zip(with: uriProperty.signal)
        
        image = viewDidLoadProperty.signal
            .combineLatest(with: imageModelsWithUri)
            .map { $0.1 }
            .flatMap(.latest, { imageProvider, uri -> SignalProducer<ImageGalleryItem, FetchError> in
                 imageProvider.fetchImageGalleryItem(forUri: uri, imageType: .largeImage)
            }).flatMapError { _ in SignalProducer(value: ImageGalleryItem(image: imagePlaceholder, uri: "Placeholder")) }
            .map({ $0.image })
    }
    
    private let imageProviderProperty = MutableProperty<ImageProvider?>(nil)
    private let uriProperty = MutableProperty<String>("")
    func configure(with imageProvider: ImageProvider, withUri uri: String) {
        imageProviderProperty.value = imageProvider
        uriProperty.value = uri
    }
    
    private let viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    let image: Signal<UIImage, Never>
}
