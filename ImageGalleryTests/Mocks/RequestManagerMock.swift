//
//  RequestManagerMock.swift
//  ImageGalleryTests
//
//  Created by Shady Mustafa on 18.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import ReactiveSwift

@testable import ImageGallery

class RequestManagerMock: CanRequestFeeds {
    
    private let scheduler: DateScheduler
    private var shouldError: Bool = false
    private var imageModels: [ImageModel]?
    
    init(scheduler: DateScheduler, shouldError: Bool = false) {
        self.scheduler = scheduler
    }
    
    func feedImagesFeed(withResponse imageModels: [ImageModel]) {
        self.imageModels = imageModels
    }
    
    func request<F: Feed>(from feed: F) -> SignalProducer<F.Model, FetchError> {
        guard !shouldError else {
            return SignalProducer(error: .noContentReturned)
            .delay(1, on: scheduler)
        }
        
        if feed is ImagesFeed {
            return SignalProducer<DataWrapper, FetchError>(value: DataWrapper<ImageModel>(data: imageModels ?? []))
                .delay(1, on: scheduler) as! SignalProducer<F.Model, FetchError>
        }
      
        fatalError("Feed not mocked yet")
    }
    
}

extension UniversalItem {
    static func make(images: [ImageModel]) -> UniversalItem {
        return UniversalItem(isPreRegistration: false, attributes: [],
                             customDimensions: [:], mediaGallery: MediaGallery.make(),
                             financeBudget: FinanceBudget.make(), htmlDescription: "",
                             makeKey: "", modelKey: "", isNew: false, hasEnvkv: false,
                             isFinancingFeature: false, isVideoEnabled: false,
                             isConditionNew: false, contact: Contact.make(),
                             created: 0.0, modified: 0.0, renewed: 0.0, version: 0,
                             makeId: 0, modelId: 0, financePlans: [], links: [],
                             images: images, features: [], sellerId: 0.0,
                             priceRating: PriceRating.make(), stPrice: STPrice.make(), segment: "",
                             title: "", url: "", vat: "", vc: "", id: 0.0)
    }
}

extension ImageModel {
    static func make(uri: String) -> ImageModel {
        return ImageModel(uri: uri, set: "")
    }
}

fileprivate extension MediaGallery {
    static func make() -> MediaGallery {
        return MediaGallery(slideShow: false, additionalAds: false)
    }
}

fileprivate extension FinanceBudget {
    static func make() -> FinanceBudget {
        let localizedFinanceBudget = LocalizedFinanceBudget(netIncome: "", downPayment: "")
        let financeBudget = FinanceBudget(netIncome: 0, downPayment: 0, loanDuration: 0, budgetStatus: "", localized: localizedFinanceBudget)
        
        return financeBudget
    }
}

fileprivate extension Contact {
    static func make() -> Contact {
        return Contact(type: "", country: "", enumType: "",
                       name: "", address1: "", address2: "",
                       phones: [], latLong: Coordinates.make(),
                       languages: "", withMobileSince: "",
                       canSendCcMail: false, openingHours: [],
                       rating: Rating.make(), homepageUrl: "",
                       logo: "", heroImage: HeroImage.make(),
                       person: Person.make())
    }
}

fileprivate extension Coordinates {
    static func make() -> Coordinates {
        return Coordinates(lon: 0.0, lat: 0.0)
    }
}

fileprivate extension Rating {
    static func make() -> Rating {
        return Rating(count: 0,
                      score: 0.0,
                      scoreLocalized: "",
                      link: "",
                      recommendationRate: 0.0,
                      adRealityRate: 0.0)
    }
}

fileprivate extension HeroImage {
    static func make() -> HeroImage {
        return HeroImage(uri: "", set: "")
    }
}

fileprivate extension Person {
    static func make() -> Person {
        return Person(name: "", logo: "", role: "")
    }
}

fileprivate extension PriceRating {
    static func make() -> PriceRating {
        return PriceRating(rating: "", ratingLabel: "", thresholdLabels: [], vehiclePriceOffset: 10)
    }
}

fileprivate extension STPrice {
    static func make() -> STPrice {
        return STPrice(grs: STPrice.STPriceGRS(amount: 100, currency: "Euro", localized: ""))
    }
}
