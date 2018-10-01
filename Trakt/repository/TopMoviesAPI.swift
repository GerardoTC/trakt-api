//
//  TopMoviesAPI.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation

class TopMoviesAPI {
    static let shared = TopMoviesAPI()
    private init() {}
    var currentTask: URLSessionDataTask!
    
    func getMoviesByPage(page:Int,query:String, completion: @escaping (_ movies:Array<Movie>) -> Void )  {
        let url = URL(string: baseServerUrl+"?page=\(page)"+query)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2", forHTTPHeaderField: "trakt-api-version")
        request.setValue("a28b532c2fb26c4df9fdf947c8f22c16b6e4d2d03a9ee74588c7088f2cf5be8a", forHTTPHeaderField: "trakt-api-key")
        request.timeoutInterval = 5000
        let task = URLSession.shared.dataTask(with: request, completionHandler:
        { (data,response,error) in
            if error == nil {
                let movies = try? JSONDecoder().decode([Movie].self, from: data!)
                completion(movies!)
            }else {
                completion([])
            }
            
        })
        currentTask = task
        task.resume()
    }
    func getCurrentTask() -> URLSessionDataTask {
        return currentTask
    }
}
