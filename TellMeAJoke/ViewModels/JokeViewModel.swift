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
    case showSetup(String)
    case showPunchline(String)
    case error
}

@MainActor
final class JokeViewModel: ObservableObject {
    private let jokeRepository: JokeRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var joke: Joke?
    @Published var uiState: JokeUiState = .loading
    
    init(jokeRepository: JokeRepositoryProtocol) {
        self.jokeRepository = jokeRepository
    }
    
    func getJoke() {
        uiState = .loading
        jokeRepository.fetchJoke()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                if case .failure(_) = completion {
                    self.uiState = .error
                }
            } receiveValue: { [weak self]  value in
                guard let self = self else { return }
                
                self.joke = value
                revealSetup()
            }.store(in: &cancellables)
    }
    
    func revealSetup() {
        guard let setup = joke?.setup else {
            uiState = .error
            return
        }
        uiState = .showSetup(setup)
    }
    
    func revealPunchline() {
        guard let punchline = joke?.punchline else {
            uiState = .error
            return
        }
        uiState = .showPunchline(punchline)
    }
}
