//
//  Genres.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 06/06/21.
//

struct Genres: Decodable {
    let genres: [Genre]
}
class Genre: Decodable {
    let id: Int
    let name: String
    var movies: Movies?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case movies
        
    }
    
}


