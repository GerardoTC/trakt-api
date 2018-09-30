//
//  ViewController.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 29/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import UIKit


protocol TopMoviesViewDelegate: class {
    
}

class ViewController: UIViewController, TopMoviesViewDelegate {
    var presenter:TopMoviesPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMVP()
    }
    
    func initMVP() {
        presenter = TopMoviesPresenter(view: self, interactor: TopMoviesInteractor())
    }
}

