//
//  JokeRepositoryImplTest.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 6/6/23.
//

import XCTest
import Combine
@testable import TellMeAJoke

final class DefaultJokeRepositoryTest: XCTestCase {
    
    private var service: JokeService!
    private var repository: JokeRepository!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        service = FakeNetworkManager()
        repository = DefaultJokeRepository(service: service)
    }
    
    override func tearDown() {
        service = nil
        repository = nil
        cancellables.removeAll()
    }

    func test_fetchJoke_returnsJoke() {
        // Given
        var joke: Joke?
        var error: Error?
        let expectation = expectation(description: "Publishes a joke")
        
        // When
        repository.fetchJoke()
            .sink { completion in
                if case .failure(let netError) = completion {
                    error = netError
                }
                
                expectation.fulfill()
            } receiveValue: { value in
                joke = value
            }.store(in: &cancellables)
        
        // Then
        wait(for: [expectation])
        
        // Assert there were no errors thrown
        XCTAssertNil(error)
        
        // Assert that a Joke was returned
        XCTAssertNotNil(joke)
    }
}
