//
//  ImageGalleryCollectionViewCell.swift
//
//  Created by Shady Mustafa on 17.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class ImageGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    let viewModel: ImageGalleryCellViewProtocol = ImageGalleryCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindViewModel()
    }
    
    func bindViewModel() {
      viewModel.outputs.image
        .observe(on: UIScheduler())
        .observeValues({ [unowned self] image in
            self.imageView.image = image
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
