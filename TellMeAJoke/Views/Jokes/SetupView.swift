//
//  JokeSetup.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI
import Combine

extension AnyTransition {
    static var fadeInOut: AnyTransition {
        opacity.animation(.easeInOut(duration: 0.5))
    }
}

struct SetupView: View {
    var text: String
    var onQuestionMarkPressed: () -> Void
    @State private var rotationValue = 0.0
    @State private var offsetValue = 0.0
    @State private var isAboutToExit = false
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            
            VStack() {
                Spacer()
                
                Text(text)
                    .modifier(JokeTextModifier(size: 24))
                    .scaleEffect(isAboutToExit ? 4 : 1)
                    .opacity(isAboutToExit ? 0 : 1)
                    .animation(.linear, value: isAboutToExit)
     
                Spacer()
                
                Image(ImageAsset.questionMark)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(rotationValue))
                    .animation(.linear(duration: 1).speed(1.2), value: rotationValue)
                    .offset(y: height * offsetValue)
                    .animation(.linear(duration: 1).speed(2.5), value: offsetValue)
                    .opacity(isAboutToExit ? 0 : 1)
                    .animation(.linear, value: isAboutToExit)
                    .onTapGesture {
                        startExitAnimation()
                    }
                    .onAppear() {
                        startAnimationLoop()
                    }
                
                Spacer()
            }
            .frame(width: width, height: height)
            
        }
        .padding(.horizontal)
        .transition(.fadeInOut)
    }
    
    private func startExitAnimation() {
        isAboutToExit = true
        cancelAnimationLoop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            onQuestionMarkPressed()
        }
    }
    
    private func cancelAnimationLoop() {
        cancellables.removeAll()
    }
    
    private func startAnimationLoop() {
        let timeIntervalInSeconds = max(Double(text.count / 10), 2.5)
        Timer.publish(every: timeIntervalInSeconds, on: .main, in: .common).autoconnect()
            .sink { _ in
                rotationValue = rotationValue == 360 ? 0 : 360
                offsetValue = -0.3
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    offsetValue = 0.0
                }
            }.store(in: &cancellables)
    }
}

struct JokeSetup_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(text: Joke.`default`.setup, onQuestionMarkPressed: {})
            .previewDisplayName("Default")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
        
        SetupView(text: Joke.`default`.setup, onQuestionMarkPressed: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}
