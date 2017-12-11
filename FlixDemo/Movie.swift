//
//  Movie.swift
//  FlixDemo
//
//  Created by Timothy Mak on 12/9/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import Foundation

class Movie {
    let BASE_URL = "https://image.tmdb.org/t/p/w500"
    
    var title: String
    var overview: String
    var releaseDate: String
    var posterUrl: URL?
    var backdropUrl: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No Title"
        overview = dictionary["overview"] as? String ?? ""
        releaseDate = dictionary["release_date"] as? String ?? ""
        
        let posterPathString = dictionary["poster_path"] as! String
        posterUrl = URL(string: BASE_URL + posterPathString)!
        
        let backdropPathString = dictionary["backdrop_path"] as! String
        backdropUrl = URL(string: BASE_URL + backdropPathString)!
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie]{
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
