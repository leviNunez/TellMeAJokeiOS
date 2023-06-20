//
//  MockNetworkManager.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
@testable import TellMeAJoke

final class FakeNetworkManager: JokeService {
    func fetchJokes<T>(by type: String) async throws -> T where T : Decodable {
        return load("\(type.capitalized)JokesResponse")
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let bundle = Bundle(for: type(of: self))
        let data: Data
        
        guard let file = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
