//
//  ImageGalleryDataSourceTests.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import XCTest

@testable import ImageGallery

class ImageGalleryDataSourceTests: XCTestCase {

    private var dataSource: ImageGalleryDataSource!
    
    override func setUp() {
        let imageModel1 = ImageModel.make(uri: "url1")
        let imageModel2 = ImageModel.make(uri: "url2")

        dataSource = ImageGalleryDataSource(imageModels: [imageModel1, imageModel2], imageProvider: ImageGalleryProviderMock())
    }

    func testValueInDataSource() {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.dataSource = dataSource
        
        XCTAssertEqual(collectionView.numberOfSections, 1)
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 2)
    }
}
