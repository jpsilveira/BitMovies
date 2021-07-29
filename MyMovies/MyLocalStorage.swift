//
//  MyLocalStorage.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 20/06/21.
//

import Foundation

class MyLocalStorage {
    
    lazy var myMoviesList: [[String: Any]] = self.getMyMoviesList()
    
    var userDefaults = UserDefaults.standard
    
    func isAlreadyAdded(id: Int) -> Bool {
        return searchMyMoviesList(movieID: id) != nil
    }
    
    func getMyMoviesList() ->  [[String: Any]] {
        return userDefaults.object(forKey: "MyMoviesList") as? [[String: Any]] ?? []
    }
    
    func setMyMoviesList() {
        userDefaults.set(myMoviesList, forKey: "MyMoviesList")
    }
    
    func addMyMoviesList(movieID: Int, title: String, posterPath: String) {
        guard !isAlreadyAdded(id: movieID) else { return }
        myMoviesList.append([
            "id": movieID,
            "title": title,
            "posterPath": posterPath
        ])
        setMyMoviesList()
        
    }
    
    func removeMyMoviesList(movieID: Int) {
        guard let index = searchMyMoviesList(movieID: movieID) else { return }
        myMoviesList.remove(at: index)
        setMyMoviesList()
    }
    
    func searchMyMoviesList(movieID: Int) -> Int? {
        return myMoviesList.firstIndex(where: { $0["id"] as? Int == movieID})
    }
}
