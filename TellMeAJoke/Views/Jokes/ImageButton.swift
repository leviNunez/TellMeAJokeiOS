//
//  ImageButton.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String
    let title: String
    let onButtonPressed: () -> Void
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 90, height: 90)
            
            Text(title)
                .modifier(JokeTextModifier())
        }
        .onTapGesture {
            onButtonPressed()
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(imageName: ImageAsset.questionMark, title: StringResource.next, onButtonPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
