//
//  SearchModel.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation

protocol SearchModel {
    func getSearchMovieByKeyword(query : String, page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
}

class SearchModelImplementation : BasicModel, SearchModel {
    
    static let shared = SearchModelImplementation()
    
    private override init() { }
    
    func getSearchMovieByKeyword(query: String, page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getSearchMovieByKeyword(query: query, page: page, completion: completion)
    }
    
}
