//
//  ImageGalleryDetailsViewControllerSnapshotsTests.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 19.07.19.

//

import Foundation

import XCTest
import FBSnapshotTestCase
import ReactiveSwift

@testable import ImageGallery

class ImageGalleryDetailsViewControllerSnapshots: FBSnapshotTestCase {
    
    private var viewController: ImageGalleryDetailsViewController!
    
    override func setUp() {
        super.setUp()

        viewController =  ImageGalleryDetailsViewController.make()
    }
    
    func testImageGalleryDetailsViewControllerWithLargeImage() {
        
        viewController.viewModel.inputs.configure(with: ImageGalleryProviderMock(), withUri: "uri1")
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
