//
//  ImageButton.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct TextButton: View {
    let imageName: String
    let title: String
    let onButtonPressed: () -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 90, height: 90)
                .onTapGesture {
                    onButtonPressed()
                }
            Text(title)
                .font(Font.custom(AppResource.Font.niceSugar, size: 18))
                .foregroundColor(Color(AppResource.ThemeColor.onPrimary))
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(imageName: AppResource.Image.questionMark, title: AppResource.Text.next, onButtonPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppResource.ThemeColor.primary))
    }
}
