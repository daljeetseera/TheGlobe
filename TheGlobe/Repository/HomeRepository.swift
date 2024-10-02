//
//  HomeRepository.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import Foundation

protocol HomeRepository: AnyObject {
    func getStories() async throws -> Stories
}

class HomeRepositoryImpl: HomeRepository {
    let networkManager = NetworkManager.shared()
    
    /// Get stories from api
    /// - Returns: List of recommendations
    func getStories() async throws -> Stories {
        return try await withCheckedThrowingContinuation { [weak self] (continuation: CheckedContinuation<Stories, Error>) in
            self?.networkManager.requestWith(path: Constants.storiesPath) { (result: Result<Stories, Error>) in
                switch result {
                case .success(let stories):
                    continuation.resume(returning: stories)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
