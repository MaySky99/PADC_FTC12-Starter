//
//  Models.swift
//  networking
//
//  Created by Cruise on 3/15/22.
//

import Foundation

struct RequestToken : Codable {
    let success : Bool
    let expiredAt : String
    let requestToken : String
    
    enum CodingKeys : String, CodingKey {
        case success
        case expiredAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct LoginSuccess : Codable {
    let success : Bool
    let expiredAt : String
    let requestToken : String
    
    enum CodingKeys : String, CodingKey {
        case success
        case expiredAt = "expires_at"
        case requestToken = "request_token"
    }
}

struct LoginFailed : Codable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
    
    enum CodingKeys : String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct LoginRequest : Codable {
    let username : String
    let password : String
    let requestToken : String
    
    enum CodingKeys : String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
}

struct MovieGenreList : Codable {
    let genres : [MovieGenre]
}

struct MovieGenre : Codable {
    let id : Int
    let name : String
//    let anotherProperty : String?
    
    func convertToGenreVO() -> GenreVO {
        let vo = GenreVO(id: id, name: name, isSelected: false)
        return vo
    }
}

var movieGenre = [MovieGenre]()

struct MovieDetail : Codable {
    let backdropPath : String?
    let originalTitle, overview : String?
    let releaseDate : String?
    let runtime : Int?
    let voteAverage : Double?
    let voteCount : Int?
    let genres : [MovieGenre]
    let productionCountries : [ProductionCountry]
    let productionCompanies : [ProductionCompany]?
    
    enum CodingKeys : String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
        case productionCountries = "production_countries"
        case productionCompanies = "production_companies"
    }
}

struct SerieDetail : Codable {
    let backdropPath : String?
    let originalName, overview : String?
    let releaseDate : String?
    let episodeRuntime : [Int]?
    let voteAverage : Double?
    let voteCount : Int?
    let genres : [MovieGenre]
    let productionCountries : [ProductionCountry]
    let productionCompanies : [ProductionCompany]?
    
    enum CodingKeys : String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalName = "original_name"
        case overview
        case releaseDate = "first_air_date"
        case episodeRuntime = "episode_run_time"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
        case productionCountries = "production_countries"
        case productionCompanies = "production_companies"
    }
}
