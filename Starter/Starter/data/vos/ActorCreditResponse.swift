//
//  ActorCreditResponse.swift
//  Starter
//
//  Created by Cruise on 3/25/22.
//

import Foundation

// MARK: - ActorCreditResponse
struct ActorCreditResponse: Codable {
    let cast, crew: [ActorCast]?
    let id: Int?
}

// MARK: - Cast
struct ActorCast: Codable {
    let id: Int?
    let originalLanguage: String?
//    let episodeCount: Int?
    let overview: String?
//    let originCountry: [OriginCountry]?
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
//    let mediaType: MediaType?
    let posterPath: String?
//    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
//    let character: String?
    let backdropPath: String?
    let popularity: Double?
    let creditID, originalTitle: String?
    let video: Bool?
    let releaseDate, title: String?
    let adult: Bool?
//    let department: Department?
//    let job: Job?

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
//        case episodeCount = "episode_count"
        case overview
//        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name
//        case mediaType = "media_type"
        case posterPath = "poster_path"
//        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
//        case character
        case backdropPath = "backdrop_path"
        case popularity
        case creditID = "credit_id"
        case originalTitle = "original_title"
        case video
        case releaseDate = "release_date"
        case title, adult
//        case department, job
    }
    
    func convertToMovieResult() -> MovieResult {
        return MovieResult(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIDS: self.genreIDS,
            id: self.id, originalLanguage: self.originalLanguage,
            originalTitle: self.originalTitle,
            originalName: self.originalName,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: self.video,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount)
    }
}

//enum Job: String, Codable {
//    case executiveProducer = "Executive Producer"
//    case producer = "Producer"
//}
//
//enum MediaType: String, Codable {
//    case movie = "movie"
//    case tv = "tv"
//}
//
//enum OriginCountry: String, Codable {
//    case ca = "CA"
//    case ru = "RU"
//    case us = "US"
//}
