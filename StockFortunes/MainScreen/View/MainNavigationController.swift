//
//  MainNavigationController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/21/21.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    let searchBarController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()

    }
    override func viewWillAppear(_ animated: Bool) {
    
    }

}


