//
//  ImageGalleryViewControllerSnapshotsTests.swift
//  MobileTests
//
//  Created by Shady Mustafa on 19.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import ReactiveSwift

@testable import ImageGallery

class ImageGalleryViewControllerSnapshots: FBSnapshotTestCase {
    
    private var viewController: ImageGalleryViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController =  ImageGalleryViewController.make()
    }
    
    func testImageGalleryViewControllerWithThumbnails() {
        let imageModels = [ImageModel.make(uri: "uri1"),
                           ImageModel.make(uri: "uri2"),
                           ImageModel.make(uri: "uri3"),
                           ImageModel.make(uri: "uri4")]
        
        viewController.viewModel.inputs.configure(with: imageModels, imageProvider: ImageGalleryProviderMock())
        viewController.loadViewIfNeeded()
        
        FBSnapshotVerifyView(viewController.view)
    }
   
}

fileprivate class ImageGalleryContentProviderMock: ImageGalleryContentProvider {
    private let shouldError: Bool
    
    init(shouldError: Bool = false) {
        self.shouldError = shouldError
    }
    
    override func request() -> SignalProducer<[ImageModel], FetchError> {
        guard !shouldError else {
            return SignalProducer(error: .noContentReturned)
        }
        
        return SignalProducer(value: [ImageModel.make(uri: "uri")])
    }
}
