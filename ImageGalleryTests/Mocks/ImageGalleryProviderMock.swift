//
//  GalleryImageProviderMock.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.

//

import Foundation
import ReactiveSwift
import UIKit

@testable import ImageGallery

class ImageGalleryProviderMock: ImageGalleryProvider {
    private var shouldError: Bool = false
    
    init(shouldError: Bool = false) {
        self.shouldError = shouldError
    }
    
    override func fetchImage(forUrl url: URL?) -> SignalProducer<(UIImage, String), FetchError> {
        guard let url = url else { return .empty }
        guard !shouldError else { return SignalProducer(error: .noContentReturned )}

        if url.absoluteString.contains("_2.jpg") {
            return SignalProducer(value: (UIImage(named: "placeholder_2")!, "placeholder_url_2"))
        } else if url.absoluteString.contains("_27.jpg") {
            return SignalProducer(value: (UIImage(named: "placeholder_27")!, "placeholder_url_27"))
        }
        
        return .empty
    }
    
    override func fetchImages(forUrls urls: [String]) -> SignalProducer<[(UIImage, String)], FetchError> {
        let producers = urls.map { fetchImage(forUrl: URL(string: $0)) }
        
        return SignalProducer(producers)
            .flatten(.merge)
            .collect()
    }
}
