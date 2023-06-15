//
//  JokeService.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

protocol JokeServiceProtocol {
    
    func fetchJoke<T: Decodable>() async throws -> T
    
}
