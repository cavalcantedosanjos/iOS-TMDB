//
//  MoviesViewController.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = MoviesViewModel()
    private let disposeBag = DisposeBag()
    
    fileprivate let endlessScrollOffset = 2
    

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
    }
    
    // MARK: - Actions
    @IBAction func reloadButtonTouchUpInside(_ sender: UIBarButtonItem) {
        viewModel.reloadMovies()
    }
    
    // MARK: - MISC
    
    func bindElements() {
        
        searchBar.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.movieName)
            .disposed(by: disposeBag)
        
        viewModel.error
            .asObservable()
            .subscribe(onNext: { [unowned self] response in
                
                if let message = response.status_message {
                    self.showAlert(title: "", message: message, buttonTitle: "Ok", dissmisBlock: {
                        // Nothing
                    })
                }
                
            }).disposed(by: disposeBag)
        
        viewModel.movies.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: String(describing: MoviesCollectionViewCell.self),
                                         cellType: MoviesCollectionViewCell.self)) {
                                            index, data, cell in
                                            cell.setup(with: data)
            }.disposed(by: disposeBag)
        
        
        collectionView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { data in
                let controller = MovieDetailTableViewController.instantiate()
                controller.movie = data
                
                self.navigationController?.pushViewController(controller, animated: true)
                
            }).disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row > (viewModel.movies.value.count - endlessScrollOffset) {
            viewModel.getUpcomingMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2 - 10
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
}
