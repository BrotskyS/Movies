//
//  MovieList.swift
//  Movies
//
//  Created by Sergiy Brotsky on 19.01.2023.
//

import Foundation

struct SortMovies {
    let name: String
    let description: String
}

enum SortMoviesEnum {
    case popular
    case unpopular
    
    func getValue() -> SortMovies {
        switch self {
        case .popular:
            return SortMovies(name: "popularity.desc", description: "Popular")
        case .unpopular:
            return SortMovies(name: "popularity.asc", description: "Unpopular")
        }
    }
}

struct MoviesList: Codable {
    let page: Int
    let results: [MovieItem]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieItem: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
