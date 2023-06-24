//
//  JokeViewModel.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine

enum JokesUiState: Equatable {
    case loading, error
    case showSetup(String), showPunchline(String)
}

@MainActor
final class JokesViewModel: ObservableObject {
    private let repository: JokesRepository
    private var currentJokeIndex = 0
    private var jokes = [Joke]()
    @Published var uiState: JokesUiState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: JokesRepository) {
        self.repository = repository
    }
    
    func nextJoke(from category: String) {
        if currentJokeIndex < jokes.count - 1 {
            currentJokeIndex += 1
            revealSetup()
        } else {
            fetchJokes(by: category)
        }
    }
    
    func revealSetup() {
        uiState = .showSetup(jokes[currentJokeIndex].setup)
    }
    
    func fetchJokes(by category: String) {
        uiState = .loading
        currentJokeIndex = 0
        repository.fetchJokes(by: category)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                if case .failure(_) = completion {
                    self.uiState = .error
                }
            } receiveValue: { [weak self]  value in
                guard let self = self else { return }
                
                self.jokes = value
                revealSetup()
            }.store(in: &cancellables)
    }
    
    func revealPunchline() {
        uiState = .showPunchline(jokes[currentJokeIndex].punchline)
    }
}
