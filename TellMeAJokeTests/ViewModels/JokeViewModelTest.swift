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
    private var repository: JokeRepositoryProtocol!
    private var viewModel: JokeViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor override func setUp() {
        repository = FakeJokeRepository()
        viewModel = JokeViewModel(jokeRepository: repository)
    }
    
    override func tearDown() {
        repository = nil
        viewModel = nil
        cancellables.removeAll()
    }
    
    @MainActor
    func test_getJoke_onSuccess_setsStateToShowSetup() {
        // Given
        var states = [JokeUiState]()
        
        // When
        viewModel.getJoke()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                states = values
                
                // Assert that the initial was loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the final state is showSetup
                XCTAssertEqual(states[1], .showSetup(Joke.example.setup))
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_getJoke_onError_setsStateToError() {
        // Given
        repository = FakeJokeRepository(shouldReturnError: true)
        var states = [JokeUiState]()
        
        // When
        viewModel.getJoke()
        
        // Then
        viewModel.$uiState
            .collect(2)
            .sink { values in
                states = values
                
                // Assert that the initial was loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the final state is error
                XCTAssertEqual(states[1], .error)
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_revealPunchline_setsStateToShowPunchline() {
        // Given
        var states = [JokeUiState]()
        
        // When
        viewModel.getJoke()
        viewModel.revealPunchline()
        
        // Then
        viewModel.$uiState
            .collect(3)
            .sink { values in
                states = values
                
                // Assert that the initial was loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the second state was showSetup
                XCTAssertEqual(states[1], .showSetup(Joke.example.setup))
                
                // Assert that the final state is showPunchline
                XCTAssertEqual(states[2], .showPunchline(Joke.example.punchline))
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_back_setsStateBackToShowSetup() {
        // Given
        var states = [JokeUiState]()
        
        // When
        viewModel.getJoke()
        viewModel.revealPunchline()
        viewModel.revealSetup()
        
        // Then
        viewModel.$uiState
            .collect(4)
            .sink { values in
                states = values
                // Assert that the initial state was loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the second state was showSetup
                XCTAssertEqual(states[1], .showSetup(Joke.example.setup))
                
                // Assert that the third state was showPunchline
                XCTAssertEqual(states[2], .showPunchline(Joke.example.punchline))
                
                // Assert that the final state is showSetup
                XCTAssertEqual(states[3], .showSetup(Joke.example.setup))
            }.store(in: &cancellables)
    }
}
