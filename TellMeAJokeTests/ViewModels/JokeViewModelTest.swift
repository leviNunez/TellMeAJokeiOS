//
//  JokeViewModelTest.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 7/6/23.
//

import XCTest
import Combine
@testable import TellMeAJoke

final class JokeViewModelTest: XCTestCase {
    private var repository: JokeRepository!
    private var viewModel: JokeViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor override func setUp() {
        repository = FakeJokeRepository()
        viewModel = JokeViewModel(repository: repository, category: Joke.Category.programming.rawValue)
    }
    
    override func tearDown() {
        repository = nil
        viewModel = nil
        cancellables.removeAll()
    }
    
    @MainActor
    func test_fetchJokes_onSuccess_setsStateToShowSetup() {
        // Given
        var states = [JokeUiState]()
        let expectation = expectation(description: "Publishes the correct states")
        
        // When
        viewModel.fetchJokes()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                states = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(states[0], .loading)
        
        // Assert that the final state is showSetup
        XCTAssertEqual(states[1], .showSetup(Joke.example.setup))
    }
    
    @MainActor
    func test_revealPunchline_setsStateToShowPunchline() {
        // Given
        var states = [JokeUiState]()
        let expectation = expectation(description: "Publishes the correct states")
        
        // When
        viewModel.fetchJokes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.revealPunchline()
        }
        
        // Then
        viewModel.$uiState
            .collect(3)
            .sink { values in
                states = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(states[0], JokeUiState.loading)
        
        // Assert that the second state was showSetup
        XCTAssertEqual(states[1], .showSetup(Joke.example.setup))
        
        // Assert that the final state is showPunchline
        XCTAssertEqual(states[2], .showPunchline(Joke.example.punchline))
    }
    
    @MainActor
    func test_fetchJokes_onError_setsStateToError() {
        // Given
        repository = FakeJokeRepository(shouldReturnError: true)
        viewModel = JokeViewModel(repository: repository, category: Joke.Category.programming.rawValue)
        var states = [JokeUiState]()
        let expectation = expectation(description: "Publishes the correct states")
        
        // When
        viewModel.fetchJokes()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                states = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(states[0], .loading)
        
        // Assert that the final state is error
        XCTAssertEqual(states[1], .error)
    }
}
