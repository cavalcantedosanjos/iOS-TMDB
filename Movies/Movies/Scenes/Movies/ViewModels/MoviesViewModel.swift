//
//  MoviesViewModel.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit
import RxSwift

class MoviesViewModel {
    
    // MARK: - Properties
    
    public var movies = Variable<[Movie]>([Movie]())
    public var error = Variable<ErrorResponse>(ErrorResponse())
    public var movieName = Variable<String>("")
    private var disposeBag = DisposeBag()
    
    private var page = 1
    private var isLoading = false
    private var isSearchMode = false
    private var genres = [Genre]()
    
    
    // MARK: - Lifecycle
    
    init() {
        getGenreList()
        
        movieName.asObservable()
            .subscribe(onNext: { [unowned self] name in
                if name.count > 3 {
                    self.getMoviesByName()
                    self.isSearchMode = true
                } else {
                    self.reloadMovies()
                    self.isSearchMode = false
                }
                
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Business Logic
    func addGenreNameInMovie(movie: Movie) -> Movie {
        
        guard let ids = movie.genre_ids else {
            return movie
        }
        
        var m = movie
        var genres = [Genre]()
        
        for id in ids {
            if  let genre = self.genres.filter({$0.id == id}).first {
                genres.append(genre)
            }
        }
        
        m.genres = genres
        return m
        
    }
    
    func handleUpcomingMoviesSucess(movies: [Movie]) {
        
        
        let sortedMovies = movies.sorted(by: { (m1, m2) -> Bool in
            m1.releaseDate.compare(m2.releaseDate) == .orderedAscending
        })
        
        var m = [Movie]()
        for s in sortedMovies {
            m.append(addGenreNameInMovie(movie: s))
        }
        
        self.movies.value.append(contentsOf: m)
    }
    
    func handleMoviesByNameSucess(movies: [Movie]) {
        
        var m = [Movie]()
        for s in movies {
            m.append(addGenreNameInMovie(movie: s))
        }
        
        self.movies.value = m
    }
    
    // MARK: - Services
    func reloadMovies() {
        page = 1
        movies.value.removeAll()
        getUpcomingMovies()
    }
    
    func getUpcomingMovies() {
        
        if isLoading || isSearchMode { return }
        
        isLoading = true
        
        _ = MoviesServices().getUpcomingMovies(page: page)
            .subscribe(onNext: { (upcommingMovies) in
                
                if  let upcommingMovies = upcommingMovies, let movies = upcommingMovies.results {
                    self.handleUpcomingMoviesSucess(movies: movies)
                }
                
                self.page += 1
                
            }, onError: { (error) in
                self.error.value = error as! ErrorResponse
            }, onCompleted: {
                self.isLoading = false
            }, onDisposed: {
                // Nothing
            })
        
    }
    
    func getMoviesByName() {
        
        _ = MoviesServices().getMovieBy(name: movieName.value)
            .subscribe(onNext: { (movies) in
                
                if  let movies = movies, let m = movies.results {
                    self.handleMoviesByNameSucess(movies: m)
                }
                
            }, onError: { (error) in
                self.error.value = error as! ErrorResponse
            }, onCompleted: {
                self.isLoading = false
            }, onDisposed:{
                // Nothing
            })
        
    }
    
    func getGenreList() {
        _ = GenreServices().getGenreList()
            .subscribe(onNext: { (genres) in
                
                if let genres = genres?.genres {
                    self.genres = genres
                }
                
                self.getUpcomingMovies()
                
            }, onError: { (error) in
                self.error.value = error as! ErrorResponse
            }, onCompleted: {
                self.isLoading = false
            }, onDisposed: {
                // Nothing
            })
    }
    
}
