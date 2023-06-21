//
//  ContentView.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    private let repository: JokesRepository
    
    init() {
        let service = NetworkManager()
        repository = DefaultJokesRepository(service: service)
    }
    
    var body: some View {
        JokeHost(viewModel: JokesViewModel(repository: repository, category: Joke.Category.programming))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
