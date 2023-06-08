//
//  JokeRepositoryImpl.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
import Combine

final class JokeRepositoryImpl: JokeRepository {
    
    private var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    func getJoke() -> Future<Joke, Error> {
        let urlString = Constants.baseURL + Endpoints.randomJoke
        
        return Future {  promise in
            Task { [weak self] in
                guard let self = self else { return promise(.failure(NetworkError.other)) }
                
                do {
                    let joke: Joke = try await self.service.fetch(urlString: urlString)
                    promise(.success(joke))
                } catch {
                    let err = error
                    promise(.failure(error))
                }
            }
        }
    }
}
