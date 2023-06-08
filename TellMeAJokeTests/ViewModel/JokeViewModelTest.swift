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
        viewModel = JokeViewModel(jokeRepository: repository)
        cancellables.removeAll()
    }
    
    override func tearDown() {
        repository = nil
        viewModel = nil
    }
    
    @MainActor
    func test_getJoke_publishesJoke() {
        // Given
        let expectation = expectation(description: "Publishes a joke")
        expectation.expectedFulfillmentCount = 2
        
        viewModel.$joke
            .dropFirst()
            .sink { value in
                // Assert joke is not nil
                XCTAssertNotNil(value)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        // When
        viewModel.getJoke()
        
        wait(for: [expectation])
    }
}
