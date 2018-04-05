//
//  GenreCollectionViewCell.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 12/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func setup(_ genre: Genre) {
        genreLabel.text = genre.name
        
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1
    }


}
