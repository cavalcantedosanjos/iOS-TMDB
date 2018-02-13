//
//  MoviesServices.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class MoviesServices {
    
    func getUpcomingMovies(page: Int) -> Observable<Movies?> {
     
        let query = "page=\(page)"
        let url = Environment.shared.createUrl(path: "movie/upcoming", query: query)
        
        return Observable.create({ (observable) -> Disposable in
    
            Service.shared.request(method: .get, url: url, onSuccess: { (data) in
                observable.onNext(JSON.decode(data: data))
            }, onFailure: { (error) in
                observable.onError(error)
            }, onCompleted: {
                observable.onCompleted()
            })
            
            return Disposables.create()
        })
    }
    
    func getMovieBy(name: String) -> Observable<Movies?>  {
        
        let query = "query=\(name)"
        let url = Environment.shared.createUrl(path: "search/movie", query: query)
        
        return Observable.create({ (observable) -> Disposable in
            
            Service.shared.request(method: .get, url: url, onSuccess: { (data) in
                observable.onNext(JSON.decode(data: data))
            }, onFailure: { (error) in
                observable.onError(error)
            }, onCompleted: {
                observable.onCompleted()
            })
            
            return Disposables.create()
        })
        
    }
}
