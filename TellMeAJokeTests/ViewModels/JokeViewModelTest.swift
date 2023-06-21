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
    private var repository: JokesRepository!
    private var viewModel: JokesViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor override func setUp() {
        repository = FakeJokeRepository()
        viewModel = JokesViewModel(repository: repository, category: Joke.Category.programming)
    }
    
    override func tearDown() {
        repository = nil
        viewModel = nil
        cancellables.removeAll()
    }
    
    @MainActor
    func test_fetchJokes_onSuccess_setsStateToShowSetup() {
        // Given
        var stateValues = [JokesUiState]()
        let expectation = expectation(description: "Collect 2 JokesUiState values")
        
        // When
        viewModel.fetchJokes()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                stateValues = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(stateValues[0], .loading)
        
        // Assert that the final state is showSetup
        XCTAssertEqual(stateValues[1], .showSetup(Joke.example.setup))
    }
    
    @MainActor
    func test_revealPunchline_setsStateToShowPunchline() {
        // Given
        var stateValues = [JokesUiState]()
        let expectation = expectation(description: "Collect 3 JokesUiState values")
        
        // When
        viewModel.fetchJokes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.revealPunchline()
        }
        
        // Then
        viewModel.$uiState
            .collect(3)
            .sink { values in
                stateValues = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(stateValues[0], JokesUiState.loading)
        
        // Assert that the second state was showSetup
        XCTAssertEqual(stateValues[1], .showSetup(Joke.example.setup))
        
        // Assert that the final state is showPunchline
        XCTAssertEqual(stateValues[2], .showPunchline(Joke.example.punchline))
    }
    
    @MainActor
    func test_nextJoke_changesCurrentJoke() {
        // Given
        var stateValues = [JokesUiState]()
        let expectation = expectation(description: "Collect 4 JokesUiState values")
        let oldJoke = Joke.example
        let newJoke = Joke(
            id: 371,
            setup: "There are 10 kinds of people in this world.",
            punchline: "Those who understand binary, those who don't, and those who weren't expecting a base 3 joke.",
            type: .programming)
        
        // When
        viewModel.fetchJokes()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.revealPunchline()
            self.viewModel.nextJoke()
        }
        
        // Then
        viewModel.$uiState
            .collect(4)
            .sink { values in
                stateValues = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(stateValues[0], JokesUiState.loading)
        
        // Assert that the second state was showSetup
        XCTAssertEqual(stateValues[1], .showSetup(oldJoke.setup))
        
        // Assert that the third state was showPunchline
        XCTAssertEqual(stateValues[2], .showPunchline(oldJoke.punchline))
        
        // Assert that the final state is showSetup with a new Joke
        XCTAssertEqual(stateValues[3], .showSetup(newJoke.setup))
    }
    
    @MainActor
    func test_fetchJokes_onError_setsStateToError() {
        // Given
        repository = FakeJokeRepository(shouldReturnError: true)
        viewModel = JokesViewModel(repository: repository, category: Joke.Category.programming)
        var stateValues = [JokesUiState]()
        let expectation = expectation(description: "Collect 2 JokesUiState values")
        
        // When
        viewModel.fetchJokes()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                stateValues = values
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation])
        
        // Assert that the initial state was loading
        XCTAssertEqual(stateValues[0], .loading)
        
        // Assert that the final state is error
        XCTAssertEqual(stateValues[1], .error)
    }
}
