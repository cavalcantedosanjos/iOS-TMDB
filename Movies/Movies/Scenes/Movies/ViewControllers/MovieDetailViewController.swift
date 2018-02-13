//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    var movie = Movie()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBActions
    
    // MARK: - MISC
    
    func setupUI() {
        guard let title = movie.title, let overview = movie.overview, let poster = movie.poster_path  else {
            return
        }
        
        self.title = title
        titleLabel.text = title
        dateLabel.text = Date.dateToString(date: movie.releaseDate, format: "dd/MM/yyyy")
        overviewLabel.text = overview
        posterImageView.loadImage(size: 500, name: poster)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

extension MovieDetailTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let genres = movie.genres {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreCollectionViewCell.self), for: indexPath) as! GenreCollectionViewCell
            cell.setup(genres[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
      
    }
    
}

extension MovieDetailTableViewController {
    // MARK: - Instantiation
    static func instantiate() -> MovieDetailTableViewController {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MovieDetailTableViewController
    }
}
