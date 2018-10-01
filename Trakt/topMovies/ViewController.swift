//
//  ViewController.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 29/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import UIKit
import SVProgressHUD


protocol TopMoviesViewDelegate: class {
    func showLoadingView()
    func hideLoadingView()
}

class ViewController: UIViewController, TopMoviesViewDelegate {
    
    
    var presenter:TopMoviesPresenterDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMVP()
        presenter.viewDidLoad()
    }
    
    
    func initMVP() {
        presenter = TopMoviesPresenter(view: self, interactor: TopMoviesInteractor())
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func showLoadingView() {
        SVProgressHUD.show()
    }
}

