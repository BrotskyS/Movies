//
//  Genres.swift
//  Movies
//
//  Created by Sergiy Brotsky on 19.01.2023.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
