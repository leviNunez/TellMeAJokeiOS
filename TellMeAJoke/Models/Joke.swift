//
//  Joke.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

struct Joke: Decodable {
    let id: Int
    let setup, punchline: String
    let type: Category
    
    enum Category: String, CaseIterable, Decodable {
        case general = "general"
        case programming = "programming"
    }
    
    static var example = Joke(
        id: 332,
        setup: "Why did the house go to the doctor?",
        punchline: "It was having window panes.",
        type: .general)
}
