//
//  JokeService.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

protocol JokeService {
    func fetchJoke<T: Decodable>() async throws -> T
}
