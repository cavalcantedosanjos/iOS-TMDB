//
//  UIImageViewExtension.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 11/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(size: Int, name: String) {
        
        let url = URL(string: Environment.shared.createImageUrl(size: size, name: name))
        
        self.kf.setImage(with: url, options: []) { (image, error, type, url) in
            if error == nil && image != nil {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "ic_image_galery")
                }
            }
        }
    }
}
