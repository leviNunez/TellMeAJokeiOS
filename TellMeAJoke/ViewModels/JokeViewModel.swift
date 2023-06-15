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
    case showSetup
    case showPunchline
    case error
}

@MainActor
final class JokeViewModel: ObservableObject {
    private let jokeRepository: JokeRepositoryProtocol
    private var publishers = Set<AnyCancellable>()
    private(set) var joke: Joke?
    @Published var uiState: JokeUIState = .loading
    
    
    init(jokeRepository: JokeRepositoryProtocol) {
        self.jokeRepository = jokeRepository
    }
    
    func getJoke() {
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
