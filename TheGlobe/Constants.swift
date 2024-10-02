//
//  Constants.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 01/10/24.
//

import Foundation

struct Constants {
    static let baseUrl: String = "https://d2c9087llvttmg.cloudfront.net/"
    static let storiesPath: String = "trending_and_sophi/recommendations.json"

    /// Messages
    static let loadingRecommendations: String = "Loading Recommendations..."
    static let noDataMessage = "No Data Found. Please try again later"
    static let notReachableMessage = "Network connection is not reachable"
    static let invalidUrlMessage = "Requested URL is not valid"
    static let requestCancelledMessage = "The request has been cancelled"
    static let wentWrongMessage = "Something went wrong. Please try again later"
}
