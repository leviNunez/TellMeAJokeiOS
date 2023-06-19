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
            Color(ColorAsset.primary)
                .ignoresSafeArea()
            
            switch viewModel.uiState {
            case .loading:
                JokeProgressView()
            case .showSetup(let setup):
                Setup(
                    text: setup,
                    onQuestionMarkPressed: { viewModel.revealPunchline() })
            case .showPunchline(let punchline):
                Punchline(
                    text: punchline,
                    onBackPressed: { viewModel.revealSetup() },
                    onNextPressed: { viewModel.fetchJoke() })
            case .error:
                ErrorView(onRetry: { viewModel.fetchJoke() })
            }
        } 
        .onAppear() {
            viewModel.fetchJoke()
        }
    }
}

struct JokeHost_Previews: PreviewProvider {
    static var previews: some View {
        JokeHost(viewModel: JokeViewModel(jokeRepository: DefaultJokeRepository(service: NetworkManager())))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
