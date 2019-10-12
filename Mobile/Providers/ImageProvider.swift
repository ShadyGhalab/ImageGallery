//
//  ImageProvider.swift
//  Mobile
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

enum ImageType {
    case thumbnail
    case largeImage
}

public protocol ImageProvider {
    func fetchImage(forUrl url: URL?) -> SignalProducer<(UIImage, String), FetchError>
    func fetchImages(forUrls urls: [String]) -> SignalProducer<[(UIImage, String)], FetchError>
}

class ImageGalleryProvider: ImageProvider {

    private let urlSession = URLSession(configuration: .default)

    func fetchImage(forUrl url: URL?) -> SignalProducer<(UIImage, String), FetchError> {
        guard let url = url else { return .empty }
        
        return  SignalProducer<(UIImage, String), FetchError> { observer, _ in

            self.urlSession.dataTask(with: url) { data, response, error in
                if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data) {
                    
                    observer.send(value: (image, url.absoluteString))
                    observer.sendCompleted()
                } else {
                    observer.send(error: .noContentReturned)
                }
                
                }.resume()
        }
    }
    
    func fetchImages(forUrls urls: [String]) -> SignalProducer<[(UIImage, String)], FetchError> {
        let producers = urls.map { fetchImage(forUrl: URL(string: $0)) }
        
        return SignalProducer(producers)
            .flatten(.merge)
            .collect()
    }
}

extension ImageProvider {
    func fetchImageGalleryItems(forUris uris: [String], imageType: ImageType) -> SignalProducer<[ImageGalleryItem], FetchError> {
       let imageUrlBuilder = ImageURlBuilder(with: imageType)
       let urls = imageUrlBuilder.buildValidUrls(forUris: uris)
        
        return fetchImages(forUrls: urls)
            .flatten()
            .map { ImageGalleryItem(image: $0.0, uri: $0.1) }
            .collect()
    }
    
    func fetchImageGalleryItem(forUri uri: String, imageType: ImageType) -> SignalProducer<ImageGalleryItem, FetchError> {
        let imageUrlBuilder = ImageURlBuilder(with: imageType)
        let urlString = imageUrlBuilder.buildValidUrl(forUri: uri)
        let url = URL(string: urlString)
        print(url)
        print(url?.path)
        print(urlString)

        return fetchImage(forUrl: url)
            .map { ImageGalleryItem(image: $0.0, uri: $0.1) }
    }
}

fileprivate struct ImageURlBuilder {
    private let imageType: ImageType
    init(with imageType: ImageType) {
        self.imageType = imageType
    }
    
    func buildValidUrls(forUris uris: [String] ) -> [String] {
        return uris.map { formatUrl(forUri: $0) }
    }
    
    func buildValidUrl(forUri uri: String ) -> String {
        return formatUrl(forUri: uri)
    }
    
    private func formatUrl(forUri uri: String ) -> String {
        return imageType == .thumbnail ? "https://\(uri)_2.jpg" : "https://\(uri)_27.jpg"
    }
}
