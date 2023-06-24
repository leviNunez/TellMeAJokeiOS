//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

struct JokesResponse: Decodable {
    let jokes: [Joke]
}

struct Joke: Decodable {
    let id: Int
    let setup, punchline: String
    let type: Category
    
    enum Category: String, CaseIterable, Identifiable, Decodable {
        case programming = "programming"
        case general = "general"
        
        var id: String { rawValue }
    }
    
    static var `default` = Joke(
        id: 398,
        setup: "Where did the API go to eat?",
        punchline: "To the RESTaurant.",
        type: .programming)
}
