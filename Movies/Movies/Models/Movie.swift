//
//  Movie.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 10/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int?
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var overview: String?
    var genre_ids: [Int]?
    var genres: [Genre]?
    var release_date: String?
    
    var releaseDate: Date {
        return Date.stringToDate(dateString: self.release_date ?? "")
    }
}
