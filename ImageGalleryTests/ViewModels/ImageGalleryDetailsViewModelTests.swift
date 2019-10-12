//
//  ImageGalleryDetailsViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import XCTest

@testable import ImageGallery

class ImageGalleryDetailsViewModelTests: XCTestCase {

    private let viewModel: ImageGalleryDetailsViewProtocol = ImageGalleryDetailsViewModel()
    private let image: TestObserver<UIImage, Never> = TestObserver()

    override func setUp() {
        viewModel.outputs.image.observe(image.observer)
    }
    
    func testConfigureViewModelWithLargeImage() {
        let imageProvider = ImageGalleryProviderMock()
        let largeImage = UIImage(named: "placeholder_27")!

        viewModel.inputs.configure(with: imageProvider, withUri: "uri1")
        viewModel.inputs.viewDidLoad()
        
        image.assertValue(largeImage)
    }
    
    func testConfigureViewModelWithFailedDownloadedLargeImage() {
        let imageProvider = ImageGalleryProviderMock(shouldError: true)
        
        viewModel.inputs.configure(with: imageProvider, withUri: "uri1")
        viewModel.inputs.viewDidLoad()
        
        image.assertValueCount(0)
    }
}
