//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

struct JokeResponse: Decodable {
    let jokes: [Joke]
}

struct Joke: Decodable {
    let id: Int
    let setup, punchline: String
    let type: Category
    
    enum Category: String, CaseIterable, Decodable {
        case general = "general"
        case programming = "programming"
    }
    
    static var example = Joke(
        id: 398,
        setup: "Where did the API go to eat?",
        punchline: "To the RESTaurant.",
        type: .programming)
}
