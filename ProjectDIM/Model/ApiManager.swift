//
//  File.swift
//  ProjectDIM
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import Foundation

class APImanager {
    
    static var shared: APImanager = APImanager()
    
    lazy var apiKey: String = {
        return "4ab431ee28d6c857393c3ade358ff335"
    }()
    
    let baseURL = "https://api.themoviedb.org/3/"
    
    var defaultURL: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.themoviedb.org"
        urlComponent.path = "/3/" 
        urlComponent.queryItems = [
            URLQueryItem(name: "api_key", value: APImanager.shared.apiKey),
        ]
        
        return urlComponent
    }
    
    // 
    public func getMovies(completion: @escaping ([MoviePreview]) -> Void) -> Void {
        NetworkManager.shared().fetchData(path: "discover/movie") { (data) in
            if let movies: MovieListDTO = try? JSONDecoder().decode(MovieListDTO.self, from: data) {
                completion(movies.transformDataToMovie())
               
            }
        }
    }   
    
    public func getDetails(movieId: Int, completion: @escaping (MovieDetail) -> Void) -> Void {
        let path = "movie/\(String(movieId))"

        NetworkManager.shared().fetchData(path: path, queries: ["append_to_response": "videos"]) { (data) in
            if let movieDetail: MovieDetailDTO = try? JSONDecoder().decode(MovieDetailDTO.self, from: data) {
                completion(MovieDetail(from: movieDetail))
                print(movieDetail)
            }
        }
    }
}
