//
//  Retry.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 12/6/23.
//

import SwiftUI

struct ErrorView: View {
    var onRetry: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(ImageAsset.cloud)
                .resizable()
                .aspectRatio(16/9, contentMode: .fit)
                .overlay {
                    Text(StringResource.error)
                        .modifier(JokeTextModifier(color: Color(.black)))
                }
            
            Spacer()
            
            ImageButton(image: ImageAsset.retry, title: StringResource.retry, onPressed: onRetry)
            
            Spacer()
        }
        .padding(.horizontal, UIScreen.main.bounds.width < 350 ? 10 : 16)
        .transition(.fadeInOut)
        
    }
}

struct Retry_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(onRetry: {})
            .previewDisplayName("Default")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
        
        ErrorView(onRetry: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
