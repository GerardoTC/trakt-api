//
//  TopMoviesdb.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TopMoviesdb {
    static let shared = TopMoviesdb()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Trakt")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init(){}
    func saveMovies(movies:Array<Movie>)  {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: context)
        
        for movie in movies{
            let newMovie = NSManagedObject(entity: entity!, insertInto: context)
            newMovie.setValue(movie.ids.imdb, forKey: "imdb")
            newMovie.setValue(movie.ids.slug, forKey: "slug")
            newMovie.setValue(movie.ids.tmdb, forKey: "tmdb")
            newMovie.setValue(movie.ids.trakt, forKey: "trakt")
            newMovie.setValue(movie.year, forKey: "year")
            newMovie.setValue(movie.title, forKey: "title")
            
            do {
                try context.save()
            } catch {
                print("Failed saving movies")
            }
        }
    }
    
    func getMovies() -> Array<Movie> {
        let context = self.getContext()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        var movies:Array<Movie> = []
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let year = data.value(forKey: "year") as! Int32
                let trakt = data.value(forKey: "trakt") as! Int32
                let tmdb = data.value(forKey: "tmdb") as! Int32
                let imdb = data.value(forKey: "imdb") as! String
                let slug = data.value(forKey: "slug") as! String
                let movieIds = MovieIds(trakt: trakt, slug: slug, imdb: imdb, tmdb: tmdb)
                let movie =  Movie(title: title, year: year, ids: movieIds)
                movies.append(movie)
            }
            
        } catch {
            
            print("Failed Reading movies")
        }
        return movies
    }
    
    func deleteData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try getContext().execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    private func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
}
