    //
    //  ViewController.swift
    //  MyMovies
    //
    //  Created by João Paulo Silveira on 03/06/21.
    //
    
    import UIKit
    import Alamofire
    
    class HomeViewController: UIViewController {
        
        var genres: [Genre] = []
        
        let columns: CGFloat = 1
        let rows: CGFloat = 2
        
        lazy var railWidth: CGFloat = collectionView.frame.width
        var railHeight: CGFloat = 150
        
        //        let spaceBetween: CGFloat = 50
        //        let spaceHeader: CGFloat = 2
        //        lazy var margin: CGFloat = 5
        
        @IBOutlet weak var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon.png"), style: .plain, target: self, action: #selector(search))
                        
            print(Date())
            
            fetchData()

        }
        
        @objc func search () {
            performSegue(withIdentifier: "HomeSearchSsegue", sender: nil )
        }
        
    }
    
    
    extension HomeViewController: RailCollectionViewCellDelegate {
        
        func didSelectItemAt(movieID: Int) {
            performSegue(withIdentifier: "HomeDetailSsegue", sender: movieID)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "HomeDetailSsegue" {
                if let detailViewController = segue.destination as? DetailViewController, let movieID = sender as? Int {
                    detailViewController.movieID = movieID
                }
            }
        }
        
    }
    
    extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return genres.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RailCollectionViewCell", for: indexPath) as? RailCollectionViewCell
            
            let genre = self.genres[indexPath.section]
            
            cell?.delegate = self
            cell?.setUpRail(movies: genre.movies?.results ?? [])
            
            return cell ?? UICollectionViewCell()
            
        }
        
    }
    
    extension HomeViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: railWidth, height: railHeight)
        }
        
        //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //
        //            return spaceBetween
        //        }
        //
        //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //
        //            return spaceHeader
        //        }
        //
        //        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //            let inset = UIEdgeInsets(top: margin,
        //                                     left: margin,
        //                                     bottom: margin,
        //                                     right: margin)
        //            return inset
        //        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            let _header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MovieCollectionReusableViewHeader", for: indexPath) as? MovieCollectionReusableViewHeader
            
            guard let header = _header else {
                return UICollectionReusableView()
            }
            
            let genre = self.genres[indexPath.section]
            
            header.textLabel.text = genre.name
            //            header?.textLabel.textAlignment = .left
            
            return header
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 44 )
        }
    }
    
    extension HomeViewController {
        
        func fetchMovies(genreID: Int, page: Int = 1, completionHandler: @escaping () -> Void) {
            
            AF.request("https://api.themoviedb.org/3/discover/movie?api_key=6fa1d34154e23d43f7512f27eb9a7c76&with_genres=\(genreID)&language=pt&page=\(page)")
                .validate()
                .responseDecodable(of: Movies.self) { (response) in
                    
                    guard let movies = response.value else {
                        print("Deu merda - \(genreID)")
                        completionHandler()
                        return
                    }
                    
                    let genre = self.genres.first(where: { $0.id == genreID })
                    genre?.movies = movies
                    print("ok2")
                    completionHandler()
                }
        }
        
        func fetchData() {
            fetchGenres {
                let dispatchGroup = DispatchGroup()
                self.genres.forEach { genre in
                    
                    dispatchGroup.enter()
                    print("enter")
                    self.fetchMovies(genreID: genre.id) {
                        dispatchGroup.leave()
                        print("leave")
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.collectionView.reloadData()
                    print("notify")
                    print(Date())
                    
                }
            }
        }
        
        func fetchGenres( completionHandler: @escaping () -> Void) {
            
            AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=6fa1d34154e23d43f7512f27eb9a7c76&language=pt")
                .validate()
                .responseDecodable(of: Genres.self) { (response) in
                    
                    guard let genres = response.value else {
                        print("Deu merda2")
                        completionHandler()
                        return }
                    
                    self.genres = genres.genres
                    
                    completionHandler()
                }
            
        }
        
        
    }
