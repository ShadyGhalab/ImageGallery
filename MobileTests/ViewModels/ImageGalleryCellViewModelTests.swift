//
//  ImageGalleryCellViewModelTests.swift
//  MobileTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import XCTest

@testable import Mobile

class ImageGalleryCellViewModelTests: XCTestCase {

    let viewModel: ImageGalleryCellViewProtocol = ImageGalleryCellViewModel()
    let image: TestObserver<UIImage, Never> = TestObserver()
    
    override func setUp() {
        viewModel.outputs.image.observe(image.observer)
    }

    func testConfigureViewModelWithImage() {
        let imageProvider: ImageProvider = GalleryImageProviderMock()

        let imageModel = ImageModel(uri: "i.ebayimg.com/00/s/MTA2NlgxNjAw/z/TaoAAOSwjkdZ57Jm/$", set: "fe4cfedffdffffffff")
        let thumbnailImage = UIImage(named: "placeholder_2")!
        viewModel.inputs.configure(with: imageProvider, imageModel: imageModel)
        
        image.assertValue(thumbnailImage)
    }

    func testConfigureViewModelWithFailedDownloadedImage() {
        let imageProvider: ImageProvider = GalleryImageProviderMock(errorEnabled: true)

        let imageModel = ImageModel(uri: "i.ebayimg.com/00/s/MTA2NlgxNjAw/z/TaoAAOSwjkdZ57Jm/$", set: "fe4cfedffdffffffff")
        viewModel.inputs.configure(with: imageProvider, imageModel: imageModel)
       
        image.assertValueCount(0)
        XCTAssertNil(image.lastValue)
    }
}
