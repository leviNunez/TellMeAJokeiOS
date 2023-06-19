//
//  ContentView.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    private let repository: JokeRepository
    
    init() {
        let service = NetworkManager()
        repository = DefaultJokeRepository(service: service)
    }
    
    var body: some View {
        JokeHost(viewModel: JokeViewModel(jokeRepository: repository))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
