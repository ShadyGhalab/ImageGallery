//
//  LoadingViewControllerSnapshotsTests.swift
//  MobileTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import ReactiveSwift

@testable import Mobile

class LoadingViewControllerSnapshots: FBSnapshotTestCase {
    
    private var viewController: LoadingViewController!
    
    override func setUp() {
        super.setUp()
       
        recordMode = false

        viewController = LoadingViewController.make()
    }
    
    func testLoadingScreenWithLoadingIndicator() {
        viewController.loadViewIfNeeded()
        
        FBSnapshotVerifyView(viewController.view)
    }
   
    func testLoadingScreenWithoutLoadingIndicator() {
        viewController.viewModel.inputs.configure(with: ImageGalleryContentProviderMock())
        viewController.loadViewIfNeeded()
        
        FBSnapshotVerifyView(viewController.view)
    }
    
    func testLoadingScreenWithError() {
        viewController.viewModel.inputs.configure(with: ImageGalleryContentProviderMock(shouldError: true))
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
