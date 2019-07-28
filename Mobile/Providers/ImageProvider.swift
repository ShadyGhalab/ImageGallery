//
//  ImageProvider.swift
//  Mobile
//
//  Created by Shady Ghalab on 16.07.19.
//  Copyright © 2019 Ebay. All rights reserved.
//

import Foundation
import ReactiveSwift
import UIKit

public protocol ImageProvider {
    func fetchImage(forUrl url: URL?) -> SignalProducer<UIImage, FetchError>
    func fetchImages(forUrls urls: [String]) -> SignalProducer<[UIImage], FetchError>
}

extension ImageProvider {
    
    func fetchImage(forUrl url: URL?) -> SignalProducer<UIImage, FetchError> {
        guard let url = url else { return .empty }
        
        return  SignalProducer<UIImage, FetchError> { observer, _ in
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data) {
                    
                    observer.send(value: image)
                    observer.sendCompleted()
                } else {
                    observer.send(error: .noContentReturned)
                }
                
                }.resume()
        }
    }
    
    func fetchImages(forUrls urls: [String]) -> SignalProducer<[UIImage], FetchError> {
        let producers = urls.map { fetchImage(forUrl: URL(string: $0)) }
        
        return SignalProducer(producers)
            .flatten(.merge)
            .collect()
            .observe(on: UIScheduler())
    }
}
