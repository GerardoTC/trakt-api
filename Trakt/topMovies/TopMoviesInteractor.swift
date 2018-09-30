//
//  TopMoviesInteractor.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

protocol TopMoviesInteractorDelegate:class {
    func getMoviesByPage(page:Int)
    func setPresenter(presenter:TopMoviesPresenterDelegate)
}

class TopMoviesInteractor:  TopMoviesInteractorDelegate {

    var presenter: TopMoviesPresenterDelegate?
    
    func getMoviesByPage(page: Int) {
        
    }
    
    func setPresenter(presenter: TopMoviesPresenterDelegate) {
        self.presenter = presenter
    }
    
}
