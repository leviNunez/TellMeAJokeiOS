//
//  DataSource.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 5/6/23.
//

import Foundation

protocol DataSource {
    func getJoke() -> Result<Joke, Error>
}
