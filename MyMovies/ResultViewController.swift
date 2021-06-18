//
//  ResultViewController.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 17/06/21.
//

import UIKit
import Kingfisher
import Alamofire

protocol ResultViewControllerDelegate {
    func didSelectItemAt(movieID: Int)
}

class ResultViewController: UIViewController {
    var delegate: ResultViewControllerDelegate?
    
    var movieSearch: [MovieResult] = []
    //    let columns: CGFloat = 1
    //    let rows: CGFloat = 2
    
    var cellWidth: CGFloat = 100
    var cellHeight: CGFloat = 150
    
    let spaceBetween: CGFloat = 8
    //    lazy var margin: CGFloat = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.backgroundColor = .systemBlue
    }
    
    func setUpMovieSearch(query: String) {
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.fetchMovieSearch(originalString: query ) {
                self.collectionView.reloadData()
            }
        }
        
    }
}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        
        let posterPath = self.movieSearch[indexPath.item].posterPath
        cell?.imageView?.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w154\(posterPath ?? "")"))
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt( movieID: self.movieSearch[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetween
        
    }
    
    func fetchMovieSearch(originalString: String, completionHandler: @escaping () -> Void) {
        
        //    var originalString = "ação"
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=6fa1d34154e23d43f7512f27eb9a7c76&language=pt&query=\(originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: MovieSearch.self) { (response) in
                
                guard let localMovieSearch = response.value else {
                    print("Deu merda")
                    completionHandler()
                    return
                }
                
                //            let genre = self.genres.first(where: { $0.id == genreID })
                self.movieSearch = localMovieSearch.results
                print(localMovieSearch)
                completionHandler()
            }
    }
    
}
