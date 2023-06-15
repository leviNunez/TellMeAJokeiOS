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
                .font(Font.custom(AppTheme.Font.niceSugar, size: 18))
                .foregroundColor(Color(AppTheme.Color.onPrimary))
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(imageName: Constant.ImageName.questionMark, title: Constant.StringResource.next, onButtonPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppTheme.Color.primary))
    }
}
