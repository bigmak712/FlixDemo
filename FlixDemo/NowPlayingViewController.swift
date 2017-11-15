//
//  NowPlayingViewController.swift
//  FlixDemo
//
//  Created by Timothy Mak on 11/15/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    let MOVIE_URL = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    let API_KEY = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: MOVIE_URL + API_KEY)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                
                for movie in movies {
                    let title = movie["title"] as! String
                    print(title)
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
