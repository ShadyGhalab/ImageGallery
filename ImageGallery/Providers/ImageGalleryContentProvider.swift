//
//  ImageGalleryProvider.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ContentProvider: AnyObject {
    associatedtype Content: Codable
    func request() -> SignalProducer<[Content], FetchError>
}

class ImageGalleryContentProvider: ContentProvider {
    private(set) var requestManager: CanRequestFeeds
    private let url: String = "https://m.mobile.de/svc/a/273550300"
    
    init(requestManager: CanRequestFeeds = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func request() -> SignalProducer<[ImageModel], FetchError> {
        return requestManager.request(from: ImagesFeed(absolutePath: url))
            .map { $0.data }
    }    
}
