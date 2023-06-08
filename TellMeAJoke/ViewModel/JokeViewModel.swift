//
//  JokeViewModel.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine

enum JokeUIState {
    case loading
    case error
    case showSetup
    case showPunchline
}

@MainActor
final class JokeViewModel: ObservableObject {
    private var jokeRepository: JokeRepository
    private var publishers = Set<AnyCancellable>()
    
    @Published var uiState: JokeUIState = .loading
    @Published var joke: Joke?
    
    init(jokeRepository: JokeRepository) {
        self.jokeRepository = jokeRepository
    }
    
    func getJoke () {
        uiState = .loading
        jokeRepository.getJoke()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                if case .failure(_) = completion {
                    self.uiState = .error
                }
            } receiveValue: { [weak self]  value in
                guard let self = self else { return }
                self.joke = value
                self.uiState = .showSetup
            }.store(in: &publishers)
    }
    
    func revealPunchline() {
        uiState = .showPunchline
    }
    
    func back() {
        uiState = .showSetup
    }
}
