//
//  ImageGalleryCollectionViewCell.swift
//
//  Created by Shady Mustafa on 17.07.19.

//

import UIKit
import ReactiveSwift
import ReactiveCocoa

private enum Constants {
    static let borderWidth: CGFloat = 0.5
    static let cornerRadius: CGFloat = 5
}

final class ImageGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    let viewModel: ImageGalleryCellViewProtocol = ImageGalleryCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeImageViewRounded()
        bindViewModel()
    }
    
    func bindViewModel() {
      viewModel.outputs.image
        .observe(on: UIScheduler())
        .observeValues({ [unowned self] image in
            self.imageView.image = image
        })
    }
    
    private func makeImageViewRounded() {
        imageView.layer.borderWidth = Constants.borderWidth
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
