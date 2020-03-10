//
//  Movie.swift
//  ProjectDIM
//
//  Created by  on 04/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import Foundation

struct MoviePreview {
    var id: Int
    var title: String
    var releaseDate: String
    var description: String
    var imageURL: String
    
    init (id: Int, title: String, releaseDate: String, description: String, imageURL: String){
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.description = description
        self.imageURL = "https://image.tmdb.org/t/p/w500\(imageURL)"
    }
}

struct MovieDetail {
    //var id: Int
    var title: String
    var subtitle: String?
    var length: String?
    var releaseDate: String
    var description: String?
    var imageURL: String?
    var backgroundImage: String?
    //var videoTrailer: String?
    
    
    init (from MovieDetailDTO: MovieDetailDTO){
        //self.id = id
        self.title = MovieDetailDTO.title
        self.subtitle = MovieDetailDTO.tagline!
        self.length = String(MovieDetailDTO.runtime!)
        self.releaseDate = MovieDetailDTO.releaseDate
        self.description = MovieDetailDTO.overview
        self.imageURL = "https://image.tmdb.org/t/p/w500\(MovieDetailDTO.posterPath!)"
        self.backgroundImage = "https://image.tmdb.org/t/p/w500\(MovieDetailDTO.backgroundImage!)"
        //self.videoTrailer = "https://www.youtube.com/watch?v=\(MovieDetailDTO.videoTrailer!)"
    }
    
}
