//
//  Punchline.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 9/6/23.
//

import SwiftUI

struct PunchlineView: View {
    var text: String
    var onBackPressed: () -> Void
    var onNextPressed: () -> Void
    @State private var isPlayingEntranceAnimation = false
    @State private var shouldShowButtons = false
    
    private let laughImage: String = {
        let images = [
            ImageAsset.laughingEmoji1,
            ImageAsset.laughingEmoji2,
            ImageAsset.laughingEmoji3,
            ImageAsset.laughingEmoji4
        ]
        return images[Int.random(in: 1..<images.count)]
    }()
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let buttonsContainerHeight = height * 0.13
            
            VStack {
                Spacer()
                
                Text(text)
                    .modifier(JokeTextModifier(size: 24))
                    .scaleEffect(isPlayingEntranceAnimation ? 1 : 4)
                    .animation(.linear, value: isPlayingEntranceAnimation)
                    .transition(.fadeInOut)
                
                Spacer()
                
                ZStack {
                    if shouldShowButtons {
                        HStack {
                            ImageButton(image: ImageAsset.back, title: StringResource.back, onPressed: onBackPressed)
                            Spacer()
                            ImageButton(image: ImageAsset.next, title: StringResource.next, onPressed: onNextPressed)
                        }
                        .transition(.fadeInOut)
                        
                    } else {
                        Image(laughImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(isPlayingEntranceAnimation ? 2.5 : 0.2, anchor: .center)
                            .animation(.linear(duration: 0.5).repeatCount(4), value: isPlayingEntranceAnimation)
                            .transition(.fadeInOut)
                        
                    }
                }
                .frame(height: buttonsContainerHeight)
                
                Spacer()
            }
            .frame(width: width, height: height)
            .onAppear() {
                startEntranceAnimation()
            }
            
        }
        .padding(.horizontal)
    }
    
    private func startEntranceAnimation() {
        isPlayingEntranceAnimation = true
        let animationDurationInSeconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationInSeconds) {
            shouldShowButtons = true
        }
    }
}

struct Punchline_Previews: PreviewProvider {
    static var previews: some View {
        PunchlineView(text: Joke.`default`.punchline, onBackPressed: {}, onNextPressed: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
            .previewDisplayName("Default")
        
        PunchlineView(text: Joke.`default`.punchline, onBackPressed: {}, onNextPressed: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
