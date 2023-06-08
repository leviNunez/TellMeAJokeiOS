//
//  TellMeAJokeApp.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import SwiftUI

@main
struct TellMeAJokeApp: App {
    private var service: NetworkService
    private var repository: JokeRepository
    
    init() {
        service = NetworkManager()
        repository = JokeRepositoryImpl(service: service)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: JokeViewModel(jokeRepository: repository))
        }
    }
}
