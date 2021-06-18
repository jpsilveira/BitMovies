//
//  DetailViewController.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 13/06/21.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    var movieID: Int = 0
    var movieDetail: MovieDetail?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var evalLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies {
            self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w154/\(self.movieDetail?.posterPath ?? "")"))
            let eval: Float = self.movieDetail?.voteAverage ?? 0
            let release: String = self.movieDetail?.releaseDate ?? ""
            self.evalLabel.text = "Avaliação: \(eval)"
            self.releaseLabel.text = "Lançamento: \(release.prefix(4))"
            self.overviewLabel.text = self.movieDetail?.overview
	           
        }

    }

    func fetchMovies(completionHandler: @escaping () -> Void) {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)?api_key=6fa1d34154e23d43f7512f27eb9a7c76&language=pt")
            .validate()
            .responseDecodable(of: MovieDetail.self) { (response) in
                
                guard let movieDetail = response.value else {
                    print("Deu merda - \(self.movieID)")
                    completionHandler()
                    return
                }
                
                print("okA")
                self.movieDetail = movieDetail
                completionHandler()
            }
    }
    
    
}
