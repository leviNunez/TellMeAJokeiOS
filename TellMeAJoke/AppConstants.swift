//
//  Constants.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation

enum CustomFont {
    static let niceSugar = "Nice-Sugar"
}

enum ColorAsset {
    static let primary = "PrimaryColor"
    static let onPrimary = "OnPrimaryColor"
    static let secondary = "SecondaryColor"
    static let secondaryVariant = "SecondaryVariant"
}

enum ImageAsset {
    static let lighting = "Lighting"
    static let questionMark = "QuestionMark"
    static let laugh1 = "Laugh1"
    static let laugh2 = "Laugh2"
    static let laugh3 = "Laugh3"
    static let laugh4 = "Laugh4"
    static let back = "Back"
    static let next = "Next"
    static let cloud = "Cloud"
    static let retry = "Retry"
    
    static func randomLaughImage() -> String {
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

