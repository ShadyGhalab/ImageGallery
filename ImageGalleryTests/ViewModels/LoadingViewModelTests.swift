//
//  LoadingViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import XCTest
import ReactiveSwift

@testable import ImageGallery

class LoadingViewModelTests: XCTestCase {
    
    private let viewModel: LoadingViewProtocol = LoadingViewModel()
    private let errorMessage: TestObserver<String, Never> = TestObserver()
    private let images: TestObserver<[ImageModel], Never> = TestObserver()
    private let finishedLoading: TestObserver<(), Never> = TestObserver()
    private let scheduler = TestScheduler()
    
    override func setUp() {
        viewModel.outputs.errorMessage.observe(errorMessage.observer)
        viewModel.outputs.images.observe(images.observer)
        viewModel.outputs.finishedLoading.observe(finishedLoading.observer)
    }
    
    func testConfigureViewModelWithImageModels() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
        
        let imageModel1 = ImageModel.make(uri: "uri1")
        let imageModel2 = ImageModel.make(uri: "uri2")
        requestManager.feedImagesFeed(withResponse: [imageModel1, imageModel2])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
        
        images.assertValue([imageModel1, imageModel2])
    }
    
    func testConfigureViewModelWithEmptyImageModels() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
 
        requestManager.feedImagesFeed(withResponse: [])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
       
        images.assertValue([])
    }
    
    func testFinishedLoadingWhenFetchingSucceed() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
        
        let imageModel1 = ImageModel.make(uri: "uri1")
        let imageModel2 = ImageModel.make(uri: "uri2")
        requestManager.feedImagesFeed(withResponse: [imageModel1, imageModel2])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
        
        finishedLoading.assertDidNotFail()
    }
    
    func testFinishedLoadingWhenFetchingFailed() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
        
        requestManager.feedImagesFeed(withResponse: [])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
        
        finishedLoading.assertDidNotFail()
    }
    
    func testErrorMessageWhenFetchingSucceed() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
        
        let imageModel1 = ImageModel.make(uri: "uri1")
        let imageModel2 = ImageModel.make(uri: "uri2")
        requestManager.feedImagesFeed(withResponse: [imageModel1, imageModel2])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
      
        XCTAssertNil(errorMessage.lastValue)
    }
    
    func testErrorMessageWhenFetchingFailed() {
        let requestManager: RequestManagerMock = RequestManagerMock(scheduler: scheduler)
        let imageGalleryContentProvider = ImageGalleryContentProvider(requestManager: requestManager)
        
        requestManager.feedImagesFeed(withResponse: [])
        
        viewModel.inputs.configure(with: imageGalleryContentProvider)
        viewModel.inputs.viewDidLoad()
        
        scheduler.advance(by: .seconds(2))
        
        errorMessage.assertValue("Something went wrong.\nPlease try again later.")
    }
}
