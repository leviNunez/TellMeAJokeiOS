//
//  JokeSetup.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI
import Combine

struct Setup: View {
    let text: String
    let onQuestionMarkPressed: () -> Void
    @State private var publishers = Set<AnyCancellable>()
    @State private var yScale = 0.0
    @State private var rotationDegrees = 0.0
    @State private var isAboutToTransition = false
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            
            VStack() {
                Spacer()
                
                Text(text)
                    .modifier(JokeTextModifier(size: 24))
                    .scaleEffect(isAboutToTransition ? 4 : 1)
                    .opacity(isAboutToTransition ? 0 : 1)
                    .animation(.linear, value: isAboutToTransition)
     
                Spacer()
                
                Image(Constant.ImageName.questionMark)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(rotationDegrees))
                    .animation(.rotation, value: rotationDegrees)
                    .offset(y: height * yScale)
                    .animation(.offset, value: yScale)
                    .opacity(isAboutToTransition ? 0 : 1)
                    .animation(.linear, value: isAboutToTransition)
                    .onTapGesture {
                        isAboutToTransition = true
                        publishers.first?.cancel()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onQuestionMarkPressed()
                        }
                    }
                    .onAppear() { startAnimationLoop() }
                
                Spacer()
            }
            .frame(width: width, height: height)
            
        }
        .padding(.horizontal)
        .transition(.fadeInOut)
    }
    
    private func startAnimationLoop() {
        let timeIntervalInSeconds = 5.0
        Timer.publish(every: timeIntervalInSeconds, on: .main, in: .common).autoconnect()
            .sink { _ in
                yScale = -0.3
                rotationDegrees = rotationDegrees == 360 ? 0 : 360
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    yScale = 0.0
                }
            }.store(in: &publishers)
    }
}

struct JokeSetup_Previews: PreviewProvider {
    static var previews: some View {
        Setup(text: Joke.example.setup, onQuestionMarkPressed: {})
            .previewDisplayName("Default")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppTheme.Color.primary))
        
        Setup(text: Joke.example.setup, onQuestionMarkPressed: {})
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(AppTheme.Color.primary))
    }
}
