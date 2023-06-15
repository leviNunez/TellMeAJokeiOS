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
        var state = viewModel.uiState
        
        // Assert that initial state is loading
        XCTAssertEqual(state, .loading)
        
        // When
        viewModel.getJoke()
        
        // Then
        viewModel.$uiState
            .dropFirst()
            .sink { value in
                state = value
                // Assert that state is set to showSetup
                XCTAssertEqual(state, .showSetup)
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_getJoke_onError_setsStateToError() {
        // Given
        repository = FakeJokeRepository(shouldReturnError: true)
        var state = viewModel.uiState
        
        // Assert that initial state is loading
        XCTAssertEqual(state, .loading)
        
        // When
        viewModel.getJoke()
        
        // Then
        viewModel.$uiState
            .dropFirst()
            .sink { value in
                state = value
                // Assert that state is set to showSetup
                XCTAssertEqual(state, .error)
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_revealPunchline_setsStateToShowPunchline() {
        // Given
        var states = [JokeUIState]()
        
        // When
        viewModel.getJoke()
        viewModel.revealPunchline()
        
        // Then
        viewModel.$uiState
            .collect(3)
            .sink { values in
                states = values
                // Assert that the initial state is loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the state is set to showSetup
                XCTAssertEqual(states[1], .showSetup)
                
                // Assert that the final state is showPunchline
                XCTAssertEqual(states[2], .showPunchline)
            }.store(in: &cancellables)
    }
    
    @MainActor
    func test_back_setsStateBackToShowSetup() {
        // Given
        var states = [JokeUIState]()
        
        // When
        viewModel.getJoke()
        viewModel.revealPunchline()
        viewModel.back()
        
        // Then
        viewModel.$uiState
            .collect(4)
            .sink { values in
                states = values
                // Assert that the initial state is loading
                XCTAssertEqual(states[0], .loading)
                
                // Assert that the state is set to showSetup
                XCTAssertEqual(states[1], .showSetup)
                
                // Assert that state is set to showPunchline
                XCTAssertEqual(states[2], .showPunchline)
                
                // Assert that the final state is showSetup
                XCTAssertEqual(states[3], .showSetup)
            }.store(in: &cancellables)
    }
}
