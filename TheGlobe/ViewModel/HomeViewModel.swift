//
//  HomeViewModel.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import Foundation

protocol HomeViewModel: AnyObject {
    var state: RecommendationsUIState { get }
    func fetchList() async
}

class HomeViewModelImpl: HomeViewModel {
    let repository: HomeRepository
    private(set) var state: RecommendationsUIState

    init(repository: HomeRepository = HomeRepositoryImpl()) {
        self.repository = repository
        self.state = RecommendationsUIState()
    }

    /// Fetch the list of recommendations
    @MainActor
    func fetchList() async {
        state.isloading = true
        Task {
            do {
                let stories = try await repository.getStories()
                state.isloading = false
                updateData(recommendations: stories.recommendations)
            } catch {
                state.isloading = false
                if let error = error as? NetworkError {
                    state.error = error.message
                } else {
                    state.error = NetworkError.noData.message
                }
            }
        }
    }

    private func updateData(recommendations: [Recommendation]) {
        state.updateList(recommendations: recommendations)
    }
}
