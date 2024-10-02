//
//  NetworkError.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import UIKit

enum NetworkError: Error {
    var message: String {
        switch self {
        case .noData:
            return Constants.noDataMessage
        case .notReachable:
            return Constants.notReachableMessage
        case .invalidUrl:
            return Constants.invalidUrlMessage
        case .custom(let message):
            return message
        case .cancelled:
            return Constants.requestCancelledMessage
        default:
            return Constants.wentWrongMessage
        }
    }

    case noData
    case invalidUrl
    case encoding
    case decoding
    case notReachable
    case unknown
    case custom(String)
    case cancelled
}
