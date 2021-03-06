//
//  RailCollectionViewCell.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 03/06/21.
//

import UIKit
import Kingfisher

protocol RailCollectionViewCellDelegate {
    func didSelectItemAt(movieID: Int)
}

class RailCollectionViewCell: UICollectionViewCell {
    var delegate: RailCollectionViewCellDelegate?
    
    var movies: [Movie] = []
    
    lazy var cellWidth: CGFloat = 100
    
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
        cell?.imageView?.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath ?? "")"))
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension RailCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt( movieID: self.movies[indexPath.item].id)
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

