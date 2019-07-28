//
//  LoadingViewModel.swift
//  Mobile
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol LoadingViewInputs {
    func configure(with provider: ImageGalleryContentProvider)
    func viewDidLoad()
}

protocol LoadingViewOutputs {
    var images: Signal<[ImageModel], Never> { get }
    var errorMessage: Signal<String, Never> { get }
    var finishedLoading: Signal<(), Never> { get }
}

protocol LoadingViewProtocol: Any {
    var inputs: LoadingViewInputs { get }
    var outputs: LoadingViewOutputs { get }
}

struct LoadingViewModel: LoadingViewInputs, LoadingViewOutputs, LoadingViewProtocol {
   
    var inputs: LoadingViewInputs { return self }
    var outputs: LoadingViewOutputs { return self }

    init() {
        
        images = viewDidLoadProperty.signal
            .combineLatest(with: imageGalleryProviderProperty.signal)
            .map { $0.1 }
            .skipNil()
            .flatMap(.latest, { provider -> SignalProducer<[ImageModel], FetchError> in
                provider.request()
            })
            .flatMapError { _ in SignalProducer(value: []) }
        
        errorMessage = images
            .skip(while: { !$0.isEmpty })
            .map { _ in "mobile.loading.error".localized }
        
        finishedLoading = images.map { _ in () }
    }
    
    private let imageGalleryProviderProperty = MutableProperty<ImageGalleryContentProvider?>(nil)
    func configure(with provider: ImageGalleryContentProvider) {
        imageGalleryProviderProperty.value = provider
    }
    
    private let viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    let images: Signal<[ImageModel], Never>
    let errorMessage: Signal<String, Never>
    let finishedLoading: Signal<(), Never>
}
