//
//  ImageGalleryViewModelTests.swift
//  MobileTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import XCTest

@testable import Mobile

class ImageGalleryViewModelTests: XCTestCase {

    private let viewModel: ImageGalleryViewProtocol = ImageGalleryViewModel()
    private let images: TestObserver<([ImageModel], ImageProvider), Never> = TestObserver()
    
    override func setUp() {
        viewModel.outputs.imagesModelsWithImageProvider.observe(images.observer)
    }

    func testConfigureViewModelWithImageModel() {
         let imageModel = ImageModel.make(uri: "url")
        
        viewModel.inputs.configure(with: [imageModel], imageProvider: ImageGalleryProviderMock())
        viewModel.inputs.viewDidLoad()
       
        XCTAssertTrue(images.lastValue?.0.isEmpty == false)
        XCTAssertTrue(images.lastValue?.0.count == 1)
    }

    func testConfigureViewModelWithEmptyImageModel() {
        viewModel.inputs.configure(with: [], imageProvider: ImageGalleryProviderMock())
        viewModel.inputs.viewDidLoad()
        
        XCTAssertTrue( images.lastValue?.0.isEmpty == true)
    }

}
