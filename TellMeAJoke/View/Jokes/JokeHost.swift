//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct JokeHost: View {
    @StateObject private var viewModel: JokeViewModel
    
    init(viewModel: @autoclosure @escaping () -> JokeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ZStack {
            Color(AppResource.ThemeColor.primary)
                .ignoresSafeArea()
            
            switch viewModel.uiState {
            case .loading:
                JokeProgressView()
            case .showSetup:
                Setup(
                    text: viewModel.joke!.setup,
                    onQuestionMarkPressed: { viewModel.revealPunchline() })
            case .showPunchline:
                Punchline(
                    text: viewModel.joke!.punchline,
                    onBackPressed: { viewModel.back() },
                    onNextPressed: { viewModel.getJoke() })
            case .error:
                ErrorView(onRetry: { viewModel.getJoke() })
            }
        } 
        .onAppear() {
            viewModel.getJoke()
        }
    }
}

struct JokeHost_Previews: PreviewProvider {
    static var previews: some View {
        JokeHost(viewModel: JokeViewModel(jokeRepository: JokeRepositoryImpl(service: NetworkManager())))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppResource.ThemeColor.primary))
    }
}
