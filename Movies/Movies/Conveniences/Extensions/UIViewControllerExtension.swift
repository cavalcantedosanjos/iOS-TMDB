//
//  UIViewControllerExtensions.swift
//  Movies
//
//  Created by João Paulo dos Anjos on 12/02/18.
//  Copyright © 2018 João Paulo dos Anjos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String, dissmisBlock: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default) { (alertAction) in
            dissmisBlock()
        }
        
        alertController.addAction(button)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
