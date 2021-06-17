//
//  MovieDetail.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 16/06/21.
//

struct MovieDetail: Decodable {

    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Float?

    enum CodingKeys: String, CodingKey {
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
