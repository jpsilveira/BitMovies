//
//  RailCollectionViewCell.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 03/06/21.
//

import UIKit
import Kingfisher

class RailCollectionViewCell: UICollectionViewCell {
    var movies: [Movie] = []
    let columns: CGFloat = 1
    let rows: CGFloat = 2
    
    lazy var cellWidth: CGFloat = 100
    
    //    let spaceBetween: CGFloat = 10
    //    lazy var margin: CGFloat = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setUpRail(movies: [Movie]) {
        self.movies = movies
        self.collectionView.reloadData()
    }
    
}


extension RailCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        
        let posterPath = self.movies[indexPath.item].posterPath
        cell?.imageView!.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath ?? "")"))
//        cell?.imageView!.image = UIImage(named:
//                                            indexPath.item % 2 == 0 ? "flor_vermelha" : "flor_branca")
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension RailCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cellWidth
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //
    //        return spaceBetween
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return spaceBetween
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        let inset = UIEdgeInsets(top: margin,
    //                                 left: margin,
    //                                 bottom: margin,
    //                                 right: margin)
    //        return inset
    //    }
    
}

