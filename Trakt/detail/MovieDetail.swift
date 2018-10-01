//
//  MovieDetail.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 01/10/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
import UIKit
class MovieDetail: UIViewController {
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    var movie : Movie!
    override func viewDidLoad() {
        movieTitle.text = movie.title
        movieYear.text = String(movie.year)
        poster.load.request(with: baseImageUrl+movie.ids.imdb)
        poster.contentMode = .scaleAspectFit
    }
}
