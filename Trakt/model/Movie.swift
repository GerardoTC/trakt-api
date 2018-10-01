//
//  Movie.swift
//  Trakt
//
//  Created by Gerardo Tarazona on 29/09/2018.
//  Copyright © 2018 Gerardo Tarazona. All rights reserved.
//

import Foundation
struct Movie: Codable {
    let title: String
    let year: Int32
    let ids: MovieIds
    
    enum movieKeys: String,CodingKey {
        case title
        case year
        case ids
    }
}


struct MovieIds: Codable {
    let trakt: Int32
    let slug: String
    let imdb: String
    let tmdb: Int32
    
    enum movieIds: String,CodingKey {
        case trakt
        case slug
        case imdb
        case tmdb
    }
}

