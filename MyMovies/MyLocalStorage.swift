//
//  MyLocalStorage.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 20/06/21.
//

import Foundation

class MyLocalStorage {
    
    var myMoviesList: [[String: Any]] = []
    var userDefaults = UserDefaults.standard
    
    func getMyMoviesList() {
        myMoviesList = userDefaults.object(forKey: "MyMoviesList") as? [[String: Any]] ?? []
        
    }
    
    func setMyMoviesList() {
        userDefaults.set(myMoviesList, forKey: "MyMoviesList")
    }
    
    func returnMyMoviesList() -> [[String: Any]] {
        return myMoviesList
    }
    
    func addMyMoviesList(movieID: Int, posterPath: String) {
        if searchMyMoviesList(movieID: movieID) == -1 {
            myMoviesList.append([
                "id": movieID,
                "posterPath": posterPath
            ])
            setMyMoviesList()
        }
    }
    
    func removeMyMoviesList(movieID: Int) {
        var position: Int
        
        position = searchMyMoviesList(movieID: movieID)
        
        if position != -1, let index = myMoviesList.firstIndex(where: { $0["id"] as? Int == movieID }) {
            myMoviesList.remove(at: index)
            setMyMoviesList()
        }
    }
    
    func searchMyMoviesList(movieID: Int) -> Int {
        
        let position = myMoviesList.firstIndex(where: { $0["id"] as? Int == movieID})
        
        return position ?? -1
    }
}

