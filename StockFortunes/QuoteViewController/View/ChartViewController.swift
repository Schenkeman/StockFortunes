//
//  ChartViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit

class ChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    override func didMove(toParent parent: UIViewController?) {
        
    }
    
    deinit {
        print("chart deinit")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        print("chart init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
