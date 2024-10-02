//
//  HomeView.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import SwiftUI

struct HomeView: View {
    private var viewModel: HomeViewModel
    @StateObject private var state: RecommendationsUIState

    init(viewModel: HomeViewModel = HomeViewModelImpl()) {
        self.viewModel = viewModel
        _state = StateObject(wrappedValue: viewModel.state)
        fetchList()
    }

    var body: some View {
        VStack(alignment: .leading) {
            if state.isloading {
                Text(Constants.loadingRecommendations)
            } else {
                if state.error != nil, let errorMessage = state.error {
                    Text(errorMessage)
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(state.recommendations, id: \.userId) { recommendation in
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    HStack {
                                        Text(recommendation.title)
                                            .font(.system(size: 20, weight: .bold, design: .default)) +

                                        Text(recommendation.showKey ? recommendation.key : "")
                                            .font(.system(size: 18, weight: .bold, design: .default))
                                            .foregroundColor(.red)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    Spacer()

                                    AsyncImage(url: recommendation.promoImage) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                    } placeholder: {
                                        Color.gray
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                
                                Text(recommendation.authors)
                                    .font(.system(size: 18, weight: .regular, design: .default))
                                    .foregroundStyle(.gray)

                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }

    private func fetchList() {
        Task {
            @MainActor in
            await viewModel.fetchList()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModelImpl())
}
