//
//  SearchViewController.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 17/06/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, ResultViewControllerDelegate	{
    
    lazy var resultViewController: ResultViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
    
    lazy var searchController = UISearchController(searchResultsController: resultViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        searchController.searchResultsUpdater = self
        resultViewController?.delegate = self
        navigationItem.searchController	 = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        let viewController = searchController.searchResultsController  as? ResultViewController
        //       viewController?.view.backgroundColor = .yellow
        viewController?.setUpMovieSearch( query: text)
        
        //        print (text)
    }
    
    func didSelectItemAt(movieID: Int) {
        performSegue(withIdentifier: "SearchDetailSegue", sender: movieID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchDetailSegue" {
            if let detailViewController = segue.destination as? DetailViewController, let movieID = sender as? Int {
                detailViewController.movieID = movieID
            }
        }
    }
}

