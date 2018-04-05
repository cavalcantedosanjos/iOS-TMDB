//
//  GenreServices.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 12/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class GenreServices {
    
    func getGenreList() -> Observable<Genres?> {
        
        let url = Environment.shared.createUrl(path: "genre/movie/list")
        
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
