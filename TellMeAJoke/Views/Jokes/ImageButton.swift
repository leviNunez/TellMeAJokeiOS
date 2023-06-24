//
//  ImageButton.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct ImageButton: View {
    var image: String
    var title: String
    var onPressed: () -> Void
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            Text(title)
                .modifier(JokeTextModifier())
        }
        .onTapGesture {
            onPressed()
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(image: ImageAsset.start, title: StringResource.next, onPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
