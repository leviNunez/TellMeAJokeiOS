//
//  JokeText.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 10/6/23.
//

import SwiftUI

struct JokeTextModifier: ViewModifier {
    var size = 18.0
    var color = Color(AppResource.ThemeColor.onPrimary)
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(Font.custom(AppResource.Font.niceSugar, size: size))
            .multilineTextAlignment(.center)
    }
}
