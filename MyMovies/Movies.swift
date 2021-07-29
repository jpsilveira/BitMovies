//
//  Movies.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 06/06/21.
//
class Movies: Decodable {
    var page: Int = 0
    let results: [Movie]
    
    init(page: Int = 0, results: [Movie]) {
        self.page = page
        self.results = results
    }
    
}

class Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        
    }
    
    init(id: Int,
    title: String,
    posterPath: String?) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }
}
