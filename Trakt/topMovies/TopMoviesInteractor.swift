//
//  TopMoviesInteractor.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

protocol TopMoviesInteractorDelegate:class {
    func getMoviesByPage(page: Int,query: String)
    func setPresenter(presenter:TopMoviesPresenterDelegate)
}

class TopMoviesInteractor:  TopMoviesInteractorDelegate {

    var presenter: TopMoviesPresenterDelegate!
    
    func getMoviesByPage(page: Int,query: String) {
        if TopMoviesAPI.shared.currentTask != nil {
            TopMoviesAPI.shared.currentTask.cancel()
        }
        
        TopMoviesAPI.shared.getMoviesByPage(page: page,query: query) { (movies) in
            if movies.count != 0{
                self.presenter.updateListMovies(movies: movies)
            }
            
        }
    }
    
    func getTopMovies() {
        TopMoviesAPI.shared.getMoviesByPage(page: 1, query: "") { (movies) in
            if movies.count != 0{
                self.presenter.updateListMovies(movies: movies)
                TopMoviesdb.shared.deleteData()
                TopMoviesdb.shared.saveMovies(movies: movies)
            }
            else {
                self.fetchInDB()
            }
        }
    }
    
    func setPresenter(presenter: TopMoviesPresenterDelegate) {
        self.presenter = presenter
    }
    
    func fetchInDB() {
        let movies = TopMoviesdb.shared.getMovies()
        if movies.count > 0 {
            self.presenter.updateListMovies(movies: movies)
        }
        else {
            self.presenter.moviesNotFound()
        }
    }
    
    
}
