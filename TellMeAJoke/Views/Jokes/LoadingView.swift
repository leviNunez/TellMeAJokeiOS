//
//  CustomProgressView.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotationDegrees = 0.0
    
    var body: some View {
        HStack {
            Image(ImageAsset.lighting)
                .resizable()
                .rotationEffect(.degrees(rotationDegrees))
                .frame(width: 50, height: 50)
                .onAppear() {
                    withAnimation(.linear(duration: 1)
                        .speed(0.8).repeatForever(autoreverses: false)) {
                            rotationDegrees = 360
                        }
                }

            Text(StringResource.jokingAround)
                .modifier(JokeTextModifier())
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
            LoadingView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}


