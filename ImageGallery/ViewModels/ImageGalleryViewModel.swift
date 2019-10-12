//
//  GalleryViewModel.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ImageGalleryViewInputs {
    func configure(with imageModels: [ImageModel], imageProvider: ImageProvider)
    func viewDidLoad()
}

protocol ImageGalleryViewOutputs {
    var imagesModelsWithImageProvider: Signal<([ImageModel], ImageProvider), Never> { get }
}

protocol ImageGalleryViewProtocol: Any {
    var inputs: ImageGalleryViewInputs { get }
    var outputs: ImageGalleryViewOutputs { get }
}

struct ImageGalleryViewModel: ImageGalleryViewInputs, ImageGalleryViewOutputs, ImageGalleryViewProtocol {
   
    var inputs: ImageGalleryViewInputs { return self }
    var outputs: ImageGalleryViewOutputs { return self }
    
    init() {
        
        imagesModelsWithImageProvider = viewDidLoadProperty.signal
            .combineLatest(with: imageProviderProperty.signal.skipNil())
            .combineLatest(with: imageModelsProperty.signal)
            .map { ($0.1, $0.0.1) }
    }
    
    private let imageModelsProperty = MutableProperty<[ImageModel]>([])
    private let imageProviderProperty = MutableProperty<ImageProvider?>(nil)
    func configure(with imageModels: [ImageModel], imageProvider: ImageProvider) {
        imageModelsProperty.value = imageModels
        imageProviderProperty.value = imageProvider
    }
    
    private let viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    let imagesModelsWithImageProvider: Signal<([ImageModel], ImageProvider), Never>
}
