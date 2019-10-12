//
//  ImageGalleryViewController.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import UIKit
import ReactiveSwift

private enum Constants {
    static let collectionViewLeftMargin: CGFloat = 10.0
    static let collectionViewRightMargin: CGFloat = 10.0
    static let noOfColumnsForIPhones: CGFloat = 2.0
    static let noOfColumnsForIPad: CGFloat = 4.0
    static let cellHeight: CGFloat = 134
    static let showImageGalleryDetails = "showImageGalleryDetails"
}

final class ImageGalleryViewController: UIViewController, StoryboardMakeable {
   
    static var storyboardName: String = "ImageGallery"
    typealias StoryboardMakeableType = ImageGalleryViewController
   
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let viewModel: ImageGalleryViewProtocol = ImageGalleryViewModel()
    private var dataSource: ImageGalleryDataSource? {
        didSet {
            collectionView.dataSource = dataSource
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        viewModel.inputs.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.outputs.imagesModelsWithImageProvider
            .observe(on: UIScheduler())
            .observeValues { [unowned self] imageModels, imageProvider  in
                self.dataSource = ImageGalleryDataSource(imageModels: imageModels, imageProvider: imageProvider)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showImageGalleryDetails,
            let viewController = segue.destination as? ImageGalleryDetailsViewController,
            let uri = sender as? String {
          
            viewController.viewModel.inputs.configure(with: ImageGalleryProvider(), withUri: uri)
        }
    }
}

extension ImageGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin = Constants.collectionViewLeftMargin + Constants.collectionViewRightMargin
        
        switch traitCollection.sizeClasses {
        case (.regular, .regular):
            return CGSize(width: (view.frame.width / Constants.noOfColumnsForIPad) - margin, height: Constants.cellHeight)
        default:
            return CGSize(width: (view.frame.width / Constants.noOfColumnsForIPhones) - margin, height: Constants.cellHeight)
        }
    }
}

extension ImageGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let uri = dataSource?.uri(for: indexPath) else { return }
       
        performSegue(withIdentifier: Constants.showImageGalleryDetails, sender: uri)
    }
}
