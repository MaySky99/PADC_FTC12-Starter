//
//  MovieModel.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation

protocol MovieModel {
    func getUpcomingMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void)
    func getTopRatedMovieList(page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularPeople(page : Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void)
}

class MovieModelImplementation : BasicModel, MovieModel {
    
    static let shared = MovieModelImplementation()
    
    private override init() { }
    
    func getUpcomingMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getUpcomingMovieList(completion: completion)
    }
    
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getPopularMovieList(completion: completion)
    }
    
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getPopularSerieList(completion: completion)
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
        networkAgent.getGenreList(completion: completion)
    }
    
    func getTopRatedMovieList(page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getTopRatedMovieList(page: page, completion: completion)
    }
    
    func getPopularPeople(page : Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void) {
        networkAgent.getPopularPeople(page: page, completion: completion)
    }
}
