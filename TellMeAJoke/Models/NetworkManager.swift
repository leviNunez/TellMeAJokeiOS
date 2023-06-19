//
//  NetworkManager.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation
import Combine

final class NetworkManager: JokeService {
    let baseURL = "https://official-joke-api.appspot.com/"
    let randomJokeEndpoint = "random_joke"
    
    func fetchJoke<T>() async throws -> T where T : Decodable {
        let urlString = baseURL + randomJokeEndpoint
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return decodedData
    }
}

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingError
    case unknownError
}
