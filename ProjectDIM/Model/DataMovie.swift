//
//  DataMovie.swift
//  ProjectDIM
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import Foundation

struct MovieListDTO: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [MoviePreviewDTO]?
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    func transformDataToMovie() -> [MoviePreview] {
        if let results = self.results {
            return results.compactMap { (movieDTO: MoviePreviewDTO)  in
                
                return MoviePreview(id: movieDTO.id, title: movieDTO.title, releaseDate: movieDTO.releaseDate, description: movieDTO.overview, imageURL: movieDTO.posterPath)
            }
        }
        
        return[]
    }
    
}

struct MoviePreviewDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
    }
}


struct MovieDetailDTO: Decodable {
    //let id: Int
    let title: String
    let tagline: String?
    let runtime: Int?
    let overview: String
    let releaseDate: String
    //let genreIds: [Int]?
    let posterPath: String?
    let backgroundImage: String?
    //let videos: VideoList?
    
    private enum CodingKeys: String, CodingKey {
        //case id
        case title
        case tagline
        case runtime
        case overview
        case releaseDate = "release_date"
        //case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backgroundImage = "backdrop_path"
        //case videoTrailer = "videos"
        
    }
}

struct VideoList {
    let videos: [Video]
}

struct Video {
    let id: String
    let key: String
}


