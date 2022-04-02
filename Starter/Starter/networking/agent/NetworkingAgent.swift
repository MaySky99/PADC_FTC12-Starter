//
//  NetworkingAgent.swift
//  Starter
//
//  Created by Cruise on 3/17/22.
//

import Foundation
import Alamofire

protocol MovieDBNetworkAgentProtocol {
    
    //Movie
    func getUpcomingMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void)
    func getTopRatedMovieList(page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getPopularPeople(page : Int, completion: @escaping (MDBResult<ActorListResponse>) -> Void)
    
    //MovieDetail
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetail>) -> Void)
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<SerieDetail>) -> Void)
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void)
    func getSerieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void)
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getSimilarSeries(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
    
    //ActorDetail
    func getActorDetailById(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void)
    func getActorCredit(id: Int, completion: @escaping (MDBResult<ActorCreditResponse>) -> Void)
    
    //Search
    func getSearchMovieByKeyword(query : String, page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void)

}

struct MovieDBNetworkAgent : MovieDBNetworkAgentProtocol {
    
    static let shared = MovieDBNetworkAgent()
    
    private init(){
    }
    
    func getUpcomingMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/upcoming?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.upcomingMovie).responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/popular?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.popularMovie)
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getPopularSerieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/tv/popular?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.popularTVSeries)
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void){
//        let url = "\(AppConstants.basicURL)/genre/movie/list?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.MovieGenres)
            .responseDecodable(of: MovieGenreList.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getTopRatedMovieList(page : Int = 1, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/top_rated?page=\(page)&api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.topRatedMovies(page))
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getPopularPeople(page : Int = 1, completion: @escaping (MDBResult<ActorListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/person/popular?page=\(page)&api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.popularActors(page))
            .responseDecodable(of: ActorListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getMovieDetail(id: Int, completion: @escaping (MDBResult<MovieDetail>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/\(id)?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.movieDetail(id))
            .responseDecodable(of: MovieDetail.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getSerieDetail(id: Int, completion: @escaping (MDBResult<SerieDetail>) -> Void){
//        let url = "\(AppConstants.basicURL)/tv/\(id)?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.seriesDetail(id))
            .responseDecodable(of: SerieDetail.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getMovieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/\(id)/credits?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.movieCredit(id))
            .responseDecodable(of: MovieCreditResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getSerieCredit(id: Int, completion: @escaping (MDBResult<MovieCreditResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/tv/\(id)/credits?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.serieCredit(id))
            .responseDecodable(of: MovieCreditResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
        
    }
    
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/\(id)/similar?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.similarMovie(id))
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getSimilarSeries(id: Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/tv/\(id)/similar?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.similarSerie(id))
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/movie/\(id)/videos?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.trailerVideo(id))
            .responseDecodable(of: MovieTrailerResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
//    func getActorDetailById(id: Int, success: @escaping (ActorDetailResponse) -> Void, failure: @escaping (String) -> Void){
//
//        let url = "\(AppConstants.basicURL)/person/\(id)?api_key=\(AppConstants.apikey)"
//
//        AF.request(url).responseDecodable(of: ActorDetailResponse.self) { response in
//
//            switch response.result {
//            case .success(let data):
//                success(data)
//            case .failure(let error):
//                failure(error.errorDescription!)
//            }
//        }
//    }
    
    func getActorDetailById(id: Int, completion: @escaping (MDBResult<ActorDetailResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/person/\(id)?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.actorDetail(id))
            .responseDecodable(of: ActorDetailResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getActorCredit(id: Int, completion: @escaping (MDBResult<ActorCreditResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/person/\(id)/combined_credits?api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.actorCredit(id))
            .responseDecodable(of: ActorCreditResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    func getSearchMovieByKeyword(query : String, page : Int, completion: @escaping (MDBResult<MovieListResponse>) -> Void){
//        let url = "\(AppConstants.basicURL)/search/multi?page=\(page)&query=\(query)&api_key=\(AppConstants.apikey)"
        
        AF.request(MDBEndpoint.searchMovie(page, query))
            .responseDecodable(of: MovieListResponse.self) { response in

            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    
    /*
     Network Error
     
     * Json serialization error
     * Wrong URL
     * Incorrect method
     * Missing credentials
     * 4xx
     * 5xx
     
     */
    
    // 3 - Customized Error Body
    fileprivate func handleError<T,E: MDBErrorModel> (
        _ response: DataResponse<T, AFError>,
        _ error: (AFError),
        _ errorBodyType : E.Type) -> String {
            
            
            var respBody : String = ""
            
            var serverErrorMessage : String?
            
            var errorBody : E?
            if let respData = response.data {
                respBody = String(data: respData, encoding: .utf8) ?? "empty response body"
                
                errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
                serverErrorMessage = errorBody?.message
            }
            
            //2 - Extract debug Info
            let respCode : Int = response.response?.statusCode ?? 0
            
            let sourcePath = response.request?.url?.absoluteString ?? "no url"
            
            //1- Essential debug info
            print(
                """
                =======================
                URL
                -> \(sourcePath)
                
                Status
                -> \(respCode)
                
                Body
                -> \(respBody)
                
                Underlying Error
                -> \(error.underlyingError!)
                
                Error Description
                -> \(error.errorDescription!)
                =======================
                """
            )
            
            //4 - Client display
            return serverErrorMessage ?? error.errorDescription ?? "underlined"
        }
}

protocol MDBErrorModel : Decodable {
    var message : String { get }
}

class MDBCommonResponseError : MDBErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage : String
    let statusCode : Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

enum MDBResult<T> {
    case success(T)
    case failure(String)
}
