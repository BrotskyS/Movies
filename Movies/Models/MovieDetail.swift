//
//  MovieDetail.swift
//  Movies
//
//  Created by Sergiy Brotsky on 20.01.2023.
//

import Foundation

// MARK: - Welcome
struct MovieDetail: Decodable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage, originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: Videos

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
    }
}

struct MovieDetaile: Decodable {
    
}

struct Videos: Codable {
    let results: [VideosResult]
}

// MARK: - Result
struct VideosResult: Codable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum Site: String, Codable {
    case youTube = "YouTube"
    
}
enum VideosType: String, Codable {
    
    case featurette = "Featurette"
    case trailer = "Trailer"
}
