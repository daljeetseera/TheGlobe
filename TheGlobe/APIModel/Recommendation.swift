//
//  Recommendation.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import Foundation

struct Stories: Codable {
    let recommendations: [Recommendation]
}

struct Recommendation: Codable {
    let title: String?
    var protectionProductValue: String?
    var protectionProduct: ProtectionProduct? {
        get {
            ProtectionProduct(rawValue: protectionProductValue ?? "")
        } set {
            protectionProductValue = newValue?.rawValue
        }
    }
    let byline: [String]?
    let promoImage: PromoImage?

    enum CodingKeys: String, CodingKey {
        case title
        case protectionProductValue = "protection_product"
        case byline
        case promoImage = "promo_image"
    }
}

struct PromoImage: Codable {
    let urls: PromoImageUrl?
}

struct PromoImageUrl: Codable {
    let size650: String?

    enum CodingKeys: String, CodingKey {
        case size650 = "650"
    }
}

enum ProtectionProduct: String {
    case red
    case yellow
}
