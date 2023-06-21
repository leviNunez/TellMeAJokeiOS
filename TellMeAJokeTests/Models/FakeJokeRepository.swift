//
//  FakeJokeRepository.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine
@testable import TellMeAJoke

class FakeJokeRepository: JokesRepository {
    private var service = FakeNetworkManager()
    private var shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchJokes(by type: String) -> Future<[Joke], Error> {
        return Future { [self] promise in
            Task {
                if shouldReturnError {
                    promise(.failure(TestError.testException))
                }
                do {
                    let jokes: [Joke] = try await service.fetchJokes(by: type)
                    promise(.success(jokes))
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
