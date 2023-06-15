//
//  Retry.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 12/6/23.
//

import SwiftUI

struct ErrorView: View {
    let onRetry: () -> Void
    
    var body: some View {
        VStack {
            Image(Constant.ImageName.explosion)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    Text(Constant.StringResource.error)
                        .modifier(JokeTextModifier(color: Color(.black)))
                }
            
            TextButton(imageName: Constant.ImageName.retry, title: Constant.StringResource.retry, onButtonPressed: onRetry)
        }
        .transition(.fadeInOut)
        .padding(.horizontal, UIScreen.main.bounds.width < 350 ? 10 : 16)
        
    }
}

struct Retry_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(onRetry: {})
            .previewDisplayName("Default")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppTheme.Color.primary))
        
        ErrorView(onRetry: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppTheme.Color.primary))
    }
}
