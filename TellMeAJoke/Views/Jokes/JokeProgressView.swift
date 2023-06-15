//
//  CustomProgressView.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 8/6/23.
//

import SwiftUI

struct JokeProgressView: View {
    @State var rotationDegrees = 0.0
    
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

            Text(StringResource.loading)
                .modifier(JokeTextModifier())
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
            JokeProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.primary))
    }
}


