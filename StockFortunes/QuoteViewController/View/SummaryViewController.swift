//
//  SummaryViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit

class SummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    deinit {
        print("summary deinit")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        print("summary init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
