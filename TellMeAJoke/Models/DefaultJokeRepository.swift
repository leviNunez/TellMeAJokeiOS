//
//  JokeRepositoryImpl.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
import Combine

final class DefaultJokeRepository: JokeRepository {
    
    private let service: JokeService
    
    init(service: JokeService) {
        self.service = service
    }
    
    func fetchJokes(by type: String) -> Future<[Joke], Error> {
        return Future {  promise in
            Task { [weak self] in
                guard let self = self else { return promise(.failure(NetworkError.unknownError)) }
                
                do {
                    let jokes: [Joke] = try await self.service.fetchJokes(by: type)
                    promise(.success(jokes))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
