//
//  MDBEndpoint.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation
import Alamofire

enum MDBEndpoint : URLConvertible {
    
    // 1 - enum case with associated value
    case searchMovie(_ page : Int, _ query : String)
    case actorCredit(_ id : Int)
    case actorDetail(_ id : Int)
    case trailerVideo(_ id : Int)
    case similarSerie(_ id : Int)
    case similarMovie(_ id : Int)
    case serieCredit(_ id : Int)
    case movieCredit(_ id : Int)
    case seriesDetail(_ id : Int)
    case movieDetail(_ id : Int)
    case popularActors(_ page : Int)
    case topRatedMovies(_ page : Int)
    case MovieGenres
    case popularTVSeries
    case popularMovie
    case upcomingMovie
    
    private var baseURL : String {
        return AppConstants.basicURL
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url : URL {
        let urlComponent = NSURLComponents(string: baseURL.appending(apiPath))
        
        if (urlComponent?.queryItems == nil){
            urlComponent?.queryItems = []
        }
        urlComponent!.queryItems!.append(contentsOf: [URLQueryItem(name: "api_key", value: AppConstants.apikey)])
        
        return urlComponent!.url!
    }
    
    private var apiPath : String {
        switch self {
        case .upcomingMovie:
            return "/movie/upcoming"
        case .popularMovie:
            return "/movie/popular"
        case .popularTVSeries:
            return "/tv/popular"
        case .MovieGenres:
            return "/genre/movie/list"
        case .topRatedMovies(let page):
            return "/movie/top_rated?page=\(page)"
        case .popularActors(let page):
            return "/person/popular?page=\(page)"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .seriesDetail(let id):
            return "/tv/\(id)"
        case .movieCredit(let id):
            return "/movie/\(id)/credits"
        case .serieCredit(let id):
            return "/tv/\(id)/credits"
        case .similarMovie(let id):
            return "/movie/\(id)/similar"
        case .similarSerie(let id):
            return "/tv/\(id)/similar"
        case .trailerVideo(let id):
            return "/movie/\(id)/videos"
        case .actorDetail(let id):
            return "/person/\(id)"
        case .actorCredit(let id):
            return "/person/\(id)/combined_credits"
        case .searchMovie(let page, let query):
            return "/search/multi?page=\(page)&query=\(query)"
        }
    }
    
}
