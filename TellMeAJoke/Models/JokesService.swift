//
//  JokeService.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

protocol JokesService {
    func fetchJokes<T: Decodable>(by type: String) async throws -> T
}
