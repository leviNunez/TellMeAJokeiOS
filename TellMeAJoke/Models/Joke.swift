//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

struct Joke: Decodable {
    let type, setup, punchline: String
    let id: Int
    
    static var example = Joke(
        type: "general",
        setup: "Why did the house go to the doctor?",
        punchline: "It was having window panes.",
        id: 332)
}
