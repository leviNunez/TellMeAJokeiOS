//
//  FakeJokeRepository.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine
@testable import TellMeAJoke

class FakeJokeRepository: JokeRepository {
    private var service = FakeNetworkManager()
    private var shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchJoke() -> Future<TellMeAJoke.Joke, Error> {
        return Future { [self] promise in
            Task {
                if shouldReturnError {
                    promise(.failure(TestError.testException))
                }
                do {
                    let joke: Joke = try await service.fetchJoke()
                    promise(.success(joke))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}

enum TestError: Error {
    case testException
}
