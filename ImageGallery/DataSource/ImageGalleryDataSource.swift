//
//  ImageGalleryDataSource.swift
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit

private enum Constants {
    static let ImageGalleryCellIdentififer = "ImageGalleryCellIdentififer"
}

class ImageGalleryDataSource: NSObject, UICollectionViewDataSource {
    
    private let imageModels: [ImageModel]
    private let imageProvider: ImageProvider
    
    init(imageModels: [ImageModel], imageProvider: ImageProvider = ImageGalleryProvider()) {
        self.imageModels = imageModels
        self.imageProvider = imageProvider
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ImageGalleryCellIdentififer,
                                                      for: indexPath) as? ImageGalleryCollectionViewCell
       
        cell?.viewModel.inputs.configure(with: imageProvider, imageModel: imageModels[indexPath.item])
        
        return cell ?? UICollectionViewCell()
    }
}

extension ImageGalleryDataSource {
    
    func uri(for indexPath: IndexPath) -> String {
       return imageModels[indexPath.item].uri
    }
}
