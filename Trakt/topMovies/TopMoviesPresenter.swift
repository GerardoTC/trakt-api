//
//  TopMoviesPresenter.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
protocol TopMoviesPresenterDelegate: class {
    func viewDidLoad()
    func updateListMovies(movies:Array<Movie>)
}

class TopMoviesPresenter:  TopMoviesPresenterDelegate {
    
    var view:TopMoviesViewDelegate!
    var interactor:TopMoviesInteractorDelegate!
    var page:Int
    var movies: Array<Movie>
    
    init(view: TopMoviesViewDelegate, interactor: TopMoviesInteractorDelegate) {
        self.page = 1
        self.movies = []
        self.view = view
        self.interactor = interactor
        interactor.setPresenter(presenter: self)
        
    }
    
    func viewDidLoad() {
        view.showLoadingView()
        interactor.getMoviesByPage(page: page)
    }
    
    func updateListMovies(movies: Array<Movie>) {
        self.movies += movies
        view.hideLoadingView()
    }
}
