//
//  MockNetworkManager.swift
//  TellMeAJokeTests
//
//  Created by Levi Nunez on 6/6/23.
//

import Foundation
@testable import TellMeAJoke

final class FakeNetworkManager: NetworkService, Mockable {
    
    func fetch<T>(urlString: String) async throws -> T where T : Decodable {
        return load("JokeResponse")
    }
}
