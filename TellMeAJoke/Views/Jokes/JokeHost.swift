//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct JokeHost: View {
    var category: Joke.Category
    @StateObject private var viewModel: JokesViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(category: Joke.Category, viewModel: @autoclosure @escaping () -> JokesViewModel) {
        self.category = category
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ZStack {
            Color(ColorAsset.primary)
                .ignoresSafeArea()
            
            switch viewModel.uiState {
            case .loading:
                LoadingView()
            case .showSetup(let setup):
                SetupView(
                    text: setup,
                    onQuestionMarkPressed: { viewModel.revealPunchline() })
            case .showPunchline(let punchline):
                PunchlineView(
                    text: punchline,
                    onBackPressed: { viewModel.revealSetup() },
                    onNextPressed: { viewModel.nextJoke(from: category.rawValue) })
            case .error:
                ErrorView(onRetry: { viewModel.fetchJokes(by: category.rawValue) })
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .principal) {
                Text(category.rawValue.capitalized)
                    .modifier(JokeTextModifier())
            }
        }
        .onAppear() {
            viewModel.fetchJokes(by: category.rawValue)
        }
    }
}

struct JokeHost_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            JokeHost(category: .general, viewModel: JokesViewModel(repository: DefaultJokesRepository(service: NetworkManager())))
        }
    }
}
