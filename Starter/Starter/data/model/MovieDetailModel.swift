//
//  MovieDetailModel.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation

protocol MovieDetailModel {
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetail>) -> Void)
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<SerieDetail>) -> Void)
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void)
    func getSerieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void)
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getSimilarSeries(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
}

class MovieDetailModelImplementation : BasicModel, MovieDetailModel{
    
    static let shared = MovieDetailModelImplementation()
    
    private override init() { }
    
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetail>) -> Void) {
        networkAgent.getMovieDetail(id: id, completion: completion)
    }
    
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<SerieDetail>) -> Void) {
        networkAgent.getSerieDetail(id: id, completion: completion)
    }
    
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void) {
        networkAgent.getMovieCredit(id: id, completion: completion)
    }
    
    func getSerieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void) {
        networkAgent.getSerieCredit(id: id, completion: completion)
    }
    
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getSimilarMovies(id: id, completion: completion)
    }
    
    func getSimilarSeries(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        networkAgent.getSimilarSeries(id: id, completion: completion)
    }
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        networkAgent.getMovieTrailerVideo(id: id, completion: completion)
    }
    
    
}
