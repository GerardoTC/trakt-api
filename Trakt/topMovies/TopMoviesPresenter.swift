//
//  TopMoviesPresenter.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
import UIKit
import ImageLoader

protocol TopMoviesPresenterDelegate: class {
    func viewDidLoad()
    func updateListMovies(movies:Array<Movie>)
    func numberOfRowsInSection() -> Int
    func moviesNotFound()
    func cellForRowAt(indexPath:IndexPath, cell: CellTopMovies) -> UITableViewCell
    func handleRefresh()
    func searchUpdated(value:String)
    func didSelectRowAt(path:IndexPath)
    
}

class TopMoviesPresenter:  TopMoviesPresenterDelegate {
    
    private var view:TopMoviesViewDelegate!
    private var interactor:TopMoviesInteractorDelegate!
    var page:Int
    var movies: Array<Movie>
    var query: String
    
    init(view: TopMoviesViewDelegate, interactor: TopMoviesInteractorDelegate) {
        self.page = 1
        self.movies = []
        self.view = view
        self.query = ""
        self.interactor = interactor
        interactor.setPresenter(presenter: self)
        
    }
    
    func viewDidLoad() {
        view.showLoadingView()
        interactor.getMoviesByPage(page: page,query: query)
    }
    
    func updateListMovies(movies: Array<Movie>) {
        self.movies += movies
        view.hideLoadingView()
        view.reloadTable()
    }
    
    func moviesNotFound() {
        view.hideLoadingView()
        view.showAlertNoMoviesFound()
    }
     func numberOfRowsInSection() -> Int {
        return self.movies.count
    }
    func cellForRowAt(indexPath:IndexPath,cell:CellTopMovies) -> UITableViewCell{
        cell.title.text = movies[indexPath.item].title
        cell.poster.load.request(with: baseImageUrl + movies[indexPath.item].ids.imdb)
        cell.poster.contentMode = .scaleAspectFit
        cell.year.text = String(movies[indexPath.item].year)
        if indexPath.item == movies.count - 1 {
            page = page + 1
            interactor.getMoviesByPage(page: page,query: query)
            view.showLoadingView()
        }
        return cell
    }
    func handleRefresh() {
        restartInfo()
        view.showLoadingView()
        interactor.getMoviesByPage(page: page,query: "")
    }
    func searchUpdated(value: String) {
        query = "&query=" + value
        restartInfo()
        view.showLoadingView()
        interactor.getMoviesByPage(page: page, query: query)
    }
    func restartInfo() {
        page = 1
        movies = []
        view.reloadTable()
    }
    func didSelectRowAt(path: IndexPath) {
        view.showDetail(movieSelected: movies[path.item])
    }
}
