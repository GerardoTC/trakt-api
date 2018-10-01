//
//  CellTopMovies.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 30/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
import UIKit

class CellTopMovies: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
