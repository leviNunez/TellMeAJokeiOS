//
//  ContentView.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: JokeViewModel
    var body: some View {
        VStack {
            switch viewModel.uiState {
            case .loading:
                ProgressView()
            case .error:
               
                Text("An error occured")
            default:
                if let joke = viewModel.joke {
                    Text(joke.setup)
                }
            }
        }.onAppear() {
            viewModel.getJoke()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: JokeViewModel(jokeRepository: JokeRepositoryImpl(service: NetworkManager())))
    }
}
