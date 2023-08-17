//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import Foundation

// MARK: - Recommendation
struct Recommendation: Codable {
    let totalResults, totalPages: Int
    let results: [Movie]
    let page: Int

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results, page
    }
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let overview, releaseDate: String
    let popularity: Double
    let voteCount: Int
    let title: String
    let posterPath, backdropPath: String?
    let voteAverage: Double
    let originalTitle: String
    let id: Int
    let originalLanguage: String
    let video: Bool
    let mediaType: MediaType
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case adult, overview
        case releaseDate = "release_date"
        case popularity
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
        case id
        case originalLanguage = "original_language"
        case video
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}
