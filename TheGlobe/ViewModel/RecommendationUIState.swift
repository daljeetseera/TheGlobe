//
//  RecommendationUIState.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 01/10/24.
//

import Foundation

class RecommendationsUIState: ObservableObject {
    @Published var isloading: Bool = false
    @Published var error: String? = nil
    @Published var recommendations: [RecommendationState] = []

    func updateList(recommendations: [Recommendation]) {
        self.recommendations = recommendations.map {
            let authors = $0.byline?.joined(separator: ", ", and: " and ")
            return RecommendationState(title: $0.title ?? "",
                                       showKey: $0.protectionProduct == .red ? true : false,
                                       authors: authors?.uppercased(),
                                       promoImage: URL(string: $0.promoImage?.urls?.size650 ?? "") )
        }
    }
}

class RecommendationState: ObservableObject {
    @Published var userId: UUID
    @Published var title: String
    @Published var showKey: Bool
    @Published var key: String
    @Published var authors: String
    @Published var promoImage: URL?

    init(title: String, showKey: Bool, authors: String?, promoImage: URL?) {
        self.userId = UUID()
        self.title = title
        self.key = " X "
        self.showKey = showKey
        self.authors = authors ?? ""
        self.promoImage = promoImage
    }
}
