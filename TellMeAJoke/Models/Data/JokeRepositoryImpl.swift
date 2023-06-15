//
//  JokeRepositoryImpl.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
import Combine

final class JokeRepositoryImpl: JokeRepositoryProtocol {
    
    private let service: JokeServiceProtocol
    
    init(service: JokeServiceProtocol) {
        self.service = service
    }
    
    func fetchJoke() -> Future<Joke, Error> {
        return Future {  promise in
            Task { [weak self] in
                guard let self = self else { return promise(.failure(NetworkError.unknownError)) }
                
                do {
                    let joke: Joke = try await self.service.fetchJoke()
                    promise(.success(joke))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
