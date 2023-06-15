//
//  Constants.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation

struct Constant {
    static let baseURL = "https://official-joke-api.appspot.com/"
    
    enum Endpoint {
        static let randomJoke = "random_joke"
    }
    
    enum ImageName {
        static let questionMark = "QuestionMark"
        static let back = "Back"
        static let next = "Next"
        static let lighting = "Lighting"
        static let explosion = "Explosion"
        static let retry = "Retry"
        static var randomLaugh: String {
            let randomInt = Int.random(in: 1...4)
            return "Laugh\(randomInt)"
        }
    }
    
    enum StringResource {
        static let appName = "Tell Me A Joke"
        static let loading = "Loading fast…"
        static let back = "Back"
        static let next = "Next"
        static let error = "Oops… I think something \nwent wrong."
        static let retry = "Retry"
    }
}
