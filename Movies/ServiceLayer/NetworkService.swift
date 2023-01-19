//
//  NetworkService.swift
//  Movies
//
//  Created by Sergiy Brotsky on 18.01.2023.
//

import Foundation
import Alamofire


struct Constant {
    static let baseAPIURL = "https://api.themoviedb.org/3"
    static let baseMediaUrl = "https://image.tmdb.org/t/p/w500"
    
}
protocol NetworkServiceProtocol: AnyObject {
    func getGenres(completion: @escaping(Result<Genres, AFError>) -> Void)
    func getMovies(page: Int, sortBy: SortMoviesEnum, completion: @escaping(Result<MoviesList, AFError>) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    
    
    func getGenres(completion: @escaping(Result<Genres, AFError>) -> Void) {
        let parameters = [
            "api_key": "0a3f77752ec54fe55f4ca58bfaf36985",
            "language": "en-US"
        ]
        
        AF.request("\(Constant.baseAPIURL)/genre/movie/list", parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Genres.self) { response in
                completion(response.result)
            }
    }
    
    func getMovies(page: Int, sortBy: SortMoviesEnum, completion: @escaping (Result<MoviesList, AFError>) -> Void) {
        let parameters = [
            "api_key": "0a3f77752ec54fe55f4ca58bfaf36985",
            "language": "en-US",
            "page": "\(page)",
            "sort_by": "\(sortBy.getValue().name)"
        ]
        
        AF.request("\(Constant.baseAPIURL)/discover/movie", parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: MoviesList.self) { response in
                completion(response.result)
            }
    }
    
    
}
