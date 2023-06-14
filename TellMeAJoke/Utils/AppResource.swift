//
//  Constants.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation

struct AppResource {
    static let baseURL = "https://official-joke-api.appspot.com/"
    
    enum Endpoint {
        static let randomJoke = "random_joke"
    }
    
    enum ThemeColor {
        static let primary = "PrimaryColor"
        static let onPrimary = "OnPrimaryColor"
        static let secondary = "SecondaryColor"
        static let secondaryVariant = "SecondaryVariant"
    }
    
    enum Font {
        static let niceSugar = "Nice-Sugar"
    }
    
    enum Image {
        static let questionMark = "QuestionMark"
        static let back = "Back"
        static let next = "Next"
        static let lighting = "Lighting"
        static let explosion = "Explosion"
        static let retry = "Retry"
        
        static var randomLaugh: String {
            "Laugh\(Int.random(in: 1...4))"
        }
    }
    
    enum Text {
        static let appName = "Tell Me A Joke"
        static let loading = "Loading fast…"
        static let back = "Back"
        static let next = "Next"
        static let error = "Oops… I think something \nwent wrong."
        static let retry = "Retry"
    }
}




