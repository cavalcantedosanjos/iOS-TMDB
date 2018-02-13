//
//  ErrorResponse.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 10/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable, Error {
    var status_code: Int?
    var status_message: String?
}
