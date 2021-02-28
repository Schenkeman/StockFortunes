//
//  QuoteViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/21/21.
//

import UIKit

class QuoteViewController: UIViewController {
    
    let quoteDataModel: QuoteDataModel
    
    init(quoteDataModel: QuoteDataModel) {
        self.quoteDataModel = quoteDataModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
