//
//  MovieApiManager.swift
//  FlixDemo
//
//  Created by Timothy Mak on 12/9/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import Foundation

class MovieApiManager {
    static let MOVIE_URL = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    static let BASE_URL = "https://image.tmdb.org/t/p/w500"
    static let API_KEY = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: MovieApiManager.MOVIE_URL + MovieApiManager.API_KEY)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
