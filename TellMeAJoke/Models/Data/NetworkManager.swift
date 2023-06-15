//
//  NetworkManager.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation
import Combine

final class NetworkManager: JokeServiceProtocol {
    
    func fetch<T>(urlString: String) async throws -> T where T : Decodable {
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let decodedJoke = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return decodedJoke
    }
}

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingError
    case unknownError
}
