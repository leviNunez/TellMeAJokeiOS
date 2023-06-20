//
//  JokeViewModel.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine

enum JokeUiState: Equatable {
    case loading
    case error
    case showSetup(String)
    case showPunchline(String)
}

@MainActor
final class JokeViewModel: ObservableObject {
    private let repository: JokeRepository
    private let category: String
    private var jokes = [Joke]()
    private var currentJokeIndex = 0
    private var cancellables = Set<AnyCancellable>()
    @Published var uiState: JokeUiState = .loading
    
    init(repository: JokeRepository, category: String) {
        self.repository = repository
        self.category = category
    }
    
    func fetchJokes() {
        uiState = .loading
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
    
    func revealSetup() {
        uiState = .showSetup(jokes[currentJokeIndex].setup)
    }
    
    func revealPunchline() {
        uiState = .showPunchline(jokes[currentJokeIndex].punchline)
    }
    
    func nextJoke() {
        if currentJokeIndex < jokes.count - 1 {
            currentJokeIndex += 1
            revealSetup()
        } else {
            currentJokeIndex = 0
            fetchJokes()
        }
    }
}
