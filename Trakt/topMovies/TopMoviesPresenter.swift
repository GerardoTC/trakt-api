//
//  TopMoviesPresenter.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
protocol TopMoviesPresenterDelegate: class {

}

class TopMoviesPresenter:  TopMoviesPresenterDelegate {
    var view:TopMoviesViewDelegate?
    var interactor:TopMoviesInteractorDelegate?
    
    init(view: TopMoviesViewDelegate, interactor: TopMoviesInteractorDelegate) {
        self.view = view
        self.interactor = interactor
        interactor.setPresenter(presenter: self)
    }
    
}
