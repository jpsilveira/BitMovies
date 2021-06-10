//
//  Movies.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 06/06/21.
//
struct Movies: Decodable {
    let page: Int
    let results: [Movie]
}
struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        
    }
}
