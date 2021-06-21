//
//  MyLocalStorage.swift
//  MyMovies
//
//  Created by João Paulo Silveira on 20/06/21.
//

import Foundation

class MyLocalStorage {
    
    var myMoviesList: [Int] = []
    var userDefaults = UserDefaults.standard
    
    func getMyMoviesList() {
        
        myMoviesList = userDefaults.object(forKey: "MyMoviesList") as! [Int]
        
    }
    
    func setMyMoviesList() {
        
        userDefaults.set(myMoviesList, forKey: "MyMoviesList")
        
    }
    
    func returnMyMoviesList()-> [Int] {
        
        return myMoviesList
        
    }
    
    func addMyMoviesList(movieID: Int) {
        
        if searchMyMoviesList(movieID: movieID) == -1 {
            
            myMoviesList.append(movieID)
            
            setMyMoviesList()
        }
    }
    
    func removeMyMoviesList(movieID: Int) {
        var position: Int
        
        position = searchMyMoviesList(movieID: movieID)
        
        if position != -1 {
            myMoviesList.remove( at: myMoviesList.firstIndex(of: movieID)!)
            setMyMoviesList()
        }
    }
    
    func searchMyMoviesList(movieID: Int) -> Int {
        
        let position = myMoviesList.first(where: {$0 == movieID})
        
        return position ?? -1
    }
}

