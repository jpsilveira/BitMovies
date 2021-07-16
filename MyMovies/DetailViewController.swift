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
    
    let myLocalStorage = MyLocalStorage()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var evalLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var myListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies {
            self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w154/\(self.movieDetail?.posterPath ?? "")"))
            let eval: Float = self.movieDetail?.voteAverage ?? 0
            let release: String = self.movieDetail?.releaseDate ?? ""
            self.evalLabel.text = "Avaliação: \(eval)"
            self.releaseLabel.text = "Lançamento: \(release.prefix(4))"
            self.overviewLabel.text = self.movieDetail?.overview
            
            self.myLocalStorage.getMyMoviesList()
            
            if self.myLocalStorage.searchMyMoviesList(movieID: self.movieDetail?.id ?? 0) == -1 {
                self.myListButton.setImage(UIImage(named: "list_add.png"), for: UIControl.State.normal)
            } else {
                self.myListButton.setImage(UIImage(named: "list_added.png"), for: UIControl.State.normal)
            }
        }
    }
    
    @IBAction func buttonClicked(_ sender: AnyObject?) {
        
        myLocalStorage.getMyMoviesList()
        
        if myLocalStorage.searchMyMoviesList(movieID: movieDetail?.id ?? 0) == -1 {
            guard let posterPath = movieDetail?.posterPath else { return }
            
            myLocalStorage.addMyMoviesList(movieID: movieID, posterPath: posterPath )
            self.myListButton.setImage(UIImage(named: "list_added.png"), for: UIControl.State.normal)
            
        } else {
            myLocalStorage.removeMyMoviesList(movieID: movieID)
            self.myListButton.setImage(UIImage(named: "list_add.png"), for: UIControl.State.normal)
        }
    }
    
    func fetchMovies(completionHandler: @escaping () -> Void) {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)?api_key=6fa1d34154e23d43f7512f27eb9a7c76&language=pt")
            .validate()
            .responseDecodable(of: MovieDetail.self) { (response) in
                
                guard let movieDetail = response.value else {
                    print("Error requesting movie detail - \(String(describing: response.value))")
                    completionHandler()
                    return
                }
                
                self.movieDetail = movieDetail
                completionHandler()
            }
    }
    
    
}
