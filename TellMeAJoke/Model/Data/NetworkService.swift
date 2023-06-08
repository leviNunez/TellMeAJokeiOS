//
//  JokeService.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

protocol NetworkService {
    
    func fetch<T: Decodable>(urlString: String) async throws -> T
    
}
