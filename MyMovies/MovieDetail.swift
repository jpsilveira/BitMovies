//
//  MovieDetail.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 16/06/21.
//

struct MovieDetail: Decodable {
    
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
