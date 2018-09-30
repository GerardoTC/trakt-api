//
//  TopMoviesAPI.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation

class TopMoviesAPI {
    func getMoviesByPage(page:Int, completion: @escaping (_ movies:Array<Movie>, _ error:Error) -> Void )  {
        let imageURL = URL(string: "https://api.trakt.tv/movies/popular")
        var request = URLRequest(url: imageURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2", forHTTPHeaderField: "trakt-api-version")
        request.setValue("a28b532c2fb26c4df9fdf947c8f22c16b6e4d2d03a9ee74588c7088f2cf5be8a", forHTTPHeaderField: "trakt-api-key")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:
        { (data,response,error) in
            if error == nil {
                let movies = try? JSONDecoder().decode([Movie].self, from: data!)
                completion(movies!,error!)
            }
            
        })
        
        task.resume()
      
    }
}
