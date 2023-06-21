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
    
    private var service: JokesService!
    private var repository: JokesRepository!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        service = FakeNetworkManager()
        repository = DefaultJokesRepository(service: service)
    }
    
    override func tearDown() {
        service = nil
        repository = nil
        cancellables.removeAll()
    }

    func test_fetchJokes_byGeneral_returnsGeneralJokes() {
        // Given
        var jokes: [Joke]?
        var error: Error?
        let expectation = expectation(description: "Publishes a list of general jokes")
        
        // When
        repository.fetchJokes(by: Joke.Category.general.rawValue)
            .sink { completion in
                if case .failure(let netError) = completion {
                    error = netError
                }
                
                expectation.fulfill()
            } receiveValue: { value in
                jokes = value
            }.store(in: &cancellables)
        
        // Then
        wait(for: [expectation])
        
        // Assert there were no errors thrown
        XCTAssertNil(error)
        
        // Assert the list is not nil
        XCTAssertNotNil(jokes)
        
        // Assert that the list contains Jokes of type general
        XCTAssertTrue(jokes!.allSatisfy({ joke in
            joke.type == .general
        }))
    }
    
    func test_fetchJokes_byProgramming_returnsProgrammingJokes() {
        // Given
        var jokes: [Joke]?
        var error: Error?
        let expectation = expectation(description: "Publishes a list of programming jokes")
        
        // When
        repository.fetchJokes(by: Joke.Category.programming.rawValue)
            .sink { completion in
                if case .failure(let netError) = completion {
                    error = netError
                }
                
                expectation.fulfill()
            } receiveValue: { value in
                jokes = value
            }.store(in: &cancellables)
        
        // Then
        wait(for: [expectation])
        
        // Assert there were no errors thrown
        XCTAssertNil(error)
        
        // Assert the list is not nil
        XCTAssertNotNil(jokes)
        
        // Assert that the list contains Jokes of type programming
        XCTAssertTrue(jokes!.allSatisfy({ joke in
            joke.type == .programming
        }))
    }
}
