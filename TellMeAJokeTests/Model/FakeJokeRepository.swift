//
//  FakeJokeRepository.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 7/6/23.
//

import Foundation
import Combine
@testable import TellMeAJoke

final class FakeJokeRepository: JokeRepository, Mockable {
    var shouldReturnError = false
    
    func getJoke() -> Future<TellMeAJoke.Joke, Error> {
        return Future { [self] promise in
            if shouldReturnError {
                promise(.failure(TestError.testException))
            } else {
                let joke: Joke = load("JokeResponse")
                promise(.success(joke))
            }
        }
    }
}

enum TestError: Error {
    case testException
}
