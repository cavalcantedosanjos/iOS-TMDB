//
//  Environment.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 10/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

class Environment {
    
    static let shared = Environment()
    
    let baseUrl = "https://api.themoviedb.org/3"
    let baseImageUrl = "https://image.tmdb.org/t/p/"
    let appKey = "3ecdf165fc2796625e55fe830994401a"
    
    func createUrl(path: String? = nil, query: String? = nil) -> String {
        
        var url = baseUrl
        
        if let path = path {
            url += "/\(path)"
        }
        
        url += "?api_key=\(appKey)"
        
        if let query = query {
             url += "&\(query)"
        }

        return url

    }
    
    func createImageUrl(size: Int, name: String) -> String {
        return "\(baseImageUrl)w\(size)\(name)"
    }
    
   
}

