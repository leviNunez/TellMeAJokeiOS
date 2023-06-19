//
//  JokeRepository.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
import Combine

protocol JokeRepository {
    func fetchJoke() -> Future<Joke, Error>
}
