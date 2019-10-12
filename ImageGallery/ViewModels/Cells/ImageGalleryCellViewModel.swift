//
//  ImageGalleryCellViewModel.swift
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

protocol ImageGalleryCellViewInputs {
    func configure(with imageProvider: ImageProvider, imageModel: ImageModel)
}

protocol ImageGalleryCellViewOutputs {
    var image: Signal<UIImage, Never> { get }
}

protocol ImageGalleryCellViewProtocol: Any {
    var inputs: ImageGalleryCellViewInputs { get }
    var outputs: ImageGalleryCellViewOutputs { get }
}

struct ImageGalleryCellViewModel: ImageGalleryCellViewInputs, ImageGalleryCellViewOutputs, ImageGalleryCellViewProtocol {
    
    var inputs: ImageGalleryCellViewInputs { return self }
    var outputs: ImageGalleryCellViewOutputs { return self }
    
    init(imagePlaceholder: UIImage = UIColor.white.image()) {
        
        image = imageModelProperty.signal.skipNil()
            .combineLatest(with: imageProviderProperty.signal.skipNil())
            .flatMap(.latest, { imageModel, imageProvider -> SignalProducer<ImageGalleryItem, FetchError> in
                imageProvider.fetchImageGalleryItem(forUri: imageModel.uri, imageType: .thumbnail)
            })
            .flatMapError { _ in SignalProducer(value: ImageGalleryItem(image: imagePlaceholder, uri: "Placeholder")) }
            .map({ $0.image })
    }
    
    private let imageModelProperty = MutableProperty<ImageModel?>(nil)
    private let imageProviderProperty = MutableProperty<ImageProvider?>(nil)
    func configure(with imageProvider: ImageProvider, imageModel: ImageModel) {
        imageModelProperty.value = imageModel
        imageProviderProperty.value = imageProvider
    }
    
    let image: Signal<UIImage, Never>
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
