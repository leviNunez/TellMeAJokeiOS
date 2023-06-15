//
//  Punchline.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 9/6/23.
//

import SwiftUI

struct Punchline: View {
    let text: String
    let onBackPressed: () -> Void
    let onNextPressed: () -> Void
    @State private var isTransitioning = false
    @State private var shouldShowButtons = false
    private let laughImage = ImageAsset.randomLaughImage()
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let buttonsContainerHeight = height * 0.13
            
            VStack {
                Spacer()
                
                Text(text)
                    .modifier(JokeTextModifier(size: 24))
                    .scaleEffect(isTransitioning ? 1 : 4)
                    .animation(.linear, value: isTransitioning)
                    .transition(.fadeInOut)
                
                Spacer()
                
                ZStack {
                    if shouldShowButtons {
                        HStack {
                            ImageButton(imageName: ImageAsset.back, title: StringResource.back, onButtonPressed: onBackPressed)
                            Spacer()
                            ImageButton(imageName: ImageAsset.next, title: StringResource.next, onButtonPressed: onNextPressed)
                        }
                        .transition(.fadeInOut)
                        
                    } else {
                        Image(laughImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(isTransitioning ? 2.5 : 0.2, anchor: .center)
                            .animation(.repeatedScaling, value: isTransitioning)
                            .transition(.fadeInOut)
                        
                    }
                }
                .frame(height: buttonsContainerHeight)
                
                Spacer()
            }
            .frame(width: width, height: height)
            .onAppear() {
                isTransitioning = true
                let timeIntervalInSeconds = 1.5
                DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalInSeconds) {
                    shouldShowButtons = true
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct Punchline_Previews: PreviewProvider {
    static var previews: some View {
        Punchline(text: Joke.example.punchline, onBackPressed: {}, onNextPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
            .previewDisplayName("Default")
        
        Punchline(text: Joke.example.punchline, onBackPressed: {}, onNextPressed: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
