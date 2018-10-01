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
    func showAlertNoMoviesFound()
    func reloadTable()
}

class ViewController: UIViewController,    UITableViewDelegate,UITableViewDataSource,TopMoviesViewDelegate, UISearchResultsUpdating {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var presenter:TopMoviesPresenterDelegate!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMVP()
        presenter.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    @objc func handleRefresh(_ refresh: UIRefreshControl)  {
        presenter.handleRefresh()
        refreshControl.endRefreshing()
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
    
    func showAlertNoMoviesFound() {
        let alert = UIAlertController(title: "No Movies Found", message: "Sorry no movies were found check your internet conection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTopMovie", for: indexPath) as? CellTopMovies else {
            fatalError("the cell does not exists")
        }
        return presenter.cellForRowAt(indexPath: indexPath, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
extension ViewController {
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text!.count > 0){
            presenter.searchUpdated(value:searchController.searchBar.text!)
        }
    }
}


