//
//  MovieDBNetworkAgentWithURLSession.swift
//  Starter
//
//  Created by Cruise on 4/1/22.
//

import Foundation

class MovieDBNetworkAgentWithURLSession : MovieDBNetworkAgentProtocol {
    
    static let shared = MovieDBNetworkAgentWithURLSession()
    
    private init() { }
    
    func getUpcomingMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.upcomingMovie.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let upcomingMovieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(.success(upcomingMovieList))
            }
        }.resume()
    }
    
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularMovie.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let popularMovieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(popularMovieList))
        }.resume()
    }
    
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let popularSerieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(popularSerieList))
        }.resume()
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
//        let url = URL(string: "\(AppConstants.basicURL)/genre/movie/list?api_key=\(AppConstants.apikey)")!
        
        var urlrequest = URLRequest(url: MDBEndpoint.MovieGenres.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let genreList = try! JSONDecoder().decode(MovieGenreList.self, from: data!)
            completion(.success(genreList))
            print(genreList.genres.count)
            
        }.resume()
    }
    
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let popularSerieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(popularSerieList))
        }.resume()
    }
    
    func getPopularPeople(page: Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let popularPeople = try! JSONDecoder().decode(ActorListResponse.self, from: data!)
            completion(.success(popularPeople))
        }.resume()
    }
    
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetail>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let movieDetail = try! JSONDecoder().decode(MovieDetail.self, from: data!)
            completion(.success(movieDetail))
        }.resume()
    }
    
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<SerieDetail>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let serieDetail = try! JSONDecoder().decode(SerieDetail.self, from: data!)
            completion(.success(serieDetail))
        }.resume()
    }
    
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let movieCredit = try! JSONDecoder().decode(MovieCreditResponse.self, from: data!)
            completion(.success(movieCredit))
        }.resume()
    }
    
    func getSerieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let serieCredit = try! JSONDecoder().decode(MovieCreditResponse.self, from: data!)
            completion(.success(serieCredit))
        }.resume()
    }
    
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let similarMovieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(similarMovieList))
        }.resume()
    }
    
    func getSimilarSeries(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let similarSerieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(similarSerieList))
        }.resume()
    }
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let movieTrailer = try! JSONDecoder().decode(MovieTrailerResponse.self, from: data!)
            completion(.success(movieTrailer))
        }.resume()
    }
    
    func getActorDetailById(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let actorDetail = try! JSONDecoder().decode(ActorDetailResponse.self, from: data!)
            completion(.success(actorDetail))
        }.resume()
    }
    
    func getActorCredit(id: Int, completion: @escaping (MDBResult<ActorCreditResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let actorCredit = try! JSONDecoder().decode(ActorCreditResponse.self, from: data!)
            completion(.success(actorCredit))
        }.resume()
    }
    
    func getSearchMovieByKeyword(query: String, page: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        var urlrequest = URLRequest(url: MDBEndpoint.popularTVSeries.url)
        urlrequest.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: urlrequest) { data, response, error in
            
            let searchMovieList = try! JSONDecoder().decode(MovieListResponse.self, from: data!)
            completion(.success(searchMovieList))
        }.resume()
    }
    
    
}
