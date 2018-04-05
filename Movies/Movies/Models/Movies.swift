//
//  UpcommingMovies.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import Foundation

struct Movies: Codable {
    var results: [Movie]?
    var page: Int?
    var total_results: Int?
    var dates: Dates?
    var total_pages: Int?
}
