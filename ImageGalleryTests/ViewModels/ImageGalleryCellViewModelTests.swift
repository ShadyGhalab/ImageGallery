//
//  ImageGalleryCellViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import XCTest

@testable import ImageGallery

class ImageGalleryCellViewModelTests: XCTestCase {
    private let placeholderImage = UIColor.black.image()
    private lazy var viewModel: ImageGalleryCellViewProtocol = ImageGalleryCellViewModel(imagePlaceholder: placeholderImage)
    
    private let image: TestObserver<UIImage, Never> = TestObserver()
   
    override func setUp() {
        viewModel.outputs.image.observe(image.observer)
    }

    func testConfigureViewModelWithThumbnailImage() {
        let imageProvider: ImageProvider = ImageGalleryProviderMock()

        let imageModel = ImageModel.make(uri: "i.BabylonHealthimg.com/00/s/MTA2NlgxNjAw/z/TaoAAOSwjkdZ57Jm/$")
        let thumbnailImage = UIImage(named: "placeholder_2")!
        viewModel.inputs.configure(with: imageProvider, imageModel: imageModel)
        
        image.assertValue(thumbnailImage)
    }

    func testConfigureViewModelWithFailedDownloadedThumbnailImage() {
        let imageProvider: ImageProvider = ImageGalleryProviderMock(shouldError: true)

        let imageModel = ImageModel.make(uri: "i.BabylonHealthimg.com/00/s/MTA2NlgxNjAw/z/TaoAAOSwjkdZ57Jm/$")
        viewModel.inputs.configure(with: imageProvider, imageModel: imageModel)
       
        image.assertValue(placeholderImage)
    }
}
