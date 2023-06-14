//
//  Animations.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 10/6/23.
//

import SwiftUI

extension Animation {
    static var rotation: Animation {
        .linear(duration: 1)
        .speed(1.2)
    }
    static var offset: Animation {
        .linear(duration: 1)
        .speed(2.5)
    }
    static var repeatedScaling: Animation {
        linear(duration: 0.5).repeatForever()
    }
}

extension AnyTransition {
    static var fadeInOut: AnyTransition {
        opacity.animation(.easeInOut(duration: 0.5))
    }
}


