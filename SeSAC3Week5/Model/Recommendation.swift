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
    let adult, video: Bool
    let originalTitle, originalLanguage: String
    let overview, releaseDate, title: String
    let posterPath, backdropPath: String? // 없는 경우가 존재
    let popularity: Double
    let voteAverage: Double
    let id, voteCount: Int
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

// Quicktype이 잘못 묶은 경우
//enum OriginalLanguage: String, Codable {
//    case ko = "ko"
//    case en = "en"
//}
