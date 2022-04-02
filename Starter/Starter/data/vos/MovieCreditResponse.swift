//
//  MovieCreditResponse.swift
//  Starter
//
//  Created by Cruise on 3/25/22.
//

import Foundation

// MARK: - MovieCreditResponse
struct MovieCreditResponse: Codable {
    let id: Int?
    let cast, crew: [MovieCast]?
}

// MARK: - Cast
struct MovieCast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: Department?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    func covertToActorInfoResponse() -> ActorInfoResponse{
        return ActorInfoResponse(
            adult: self.adult,
            gender: self.gender,
            id: self.id,
            knownFor: nil,
            knownForDepartment: self.knownForDepartment,
            name: self.name,
            popularity: self.popularity,
            profilePath: self.profilePath)
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
