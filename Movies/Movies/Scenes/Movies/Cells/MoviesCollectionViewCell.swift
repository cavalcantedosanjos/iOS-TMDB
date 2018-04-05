//
//  MoviesCollectionViewCell.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func setup(with movie: Movie) {
        guard let name = movie.title, let poster = movie.poster_path else {
            return
        }

        nameLabel.text = name
        dateLabel.text = Date.dateToString(date: movie.releaseDate, format: "dd/MM/yyyy")
        posterImageView.loadImage(size: 500, name: poster)
    }
    
}
