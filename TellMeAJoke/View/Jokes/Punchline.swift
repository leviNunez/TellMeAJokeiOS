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
    @State private var shouldShowControls = false
    
    private let laughImage = AppResource.Image.randomLaugh
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            
            VStack {
                Spacer()
                
                Text(text)
                    .modifier(JokeTextModifier(size: 24)) 
                    .scaleEffect(isTransitioning ? 1 : 4)
                    .animation(.linear, value: isTransitioning)
                    .transition(.fadeInOut)
                
                Spacer()
                
                ZStack {
                    if shouldShowControls {
                        HStack {
                            TextButton(imageName: AppResource.Image.back, title: AppResource.Text.back, onButtonPressed: onBackPressed)
                            Spacer()
                            TextButton(imageName: AppResource.Image.next, title: AppResource.Text.next, onButtonPressed: onNextPressed)
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
                .frame(height: height * 0.13)
                .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
            .frame(width: width, height: height)
            .onAppear() {
                isTransitioning = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    shouldShowControls = true
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
            .background(Color(AppResource.ThemeColor.primary))
            .previewDisplayName("Default")
        
        Punchline(text: Joke.example.punchline, onBackPressed: {}, onNextPressed: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppResource.ThemeColor.primary))
    }
}
