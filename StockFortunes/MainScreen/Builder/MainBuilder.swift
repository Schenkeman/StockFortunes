//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/17/21.
//

import UIKit


protocol ModuleBuilder {
    typealias Listener = ([QuoteDataModel]) -> ()
    func build() -> UICollectionViewController
    func fetchInitialQuotes(symbol: String) -> [QuoteDataModel]
}

class MainBuilder: ModuleBuilder {
    
    func fetchInitialQuotes(symbol: String = "AAPL") -> [QuoteDataModel] {
        let dataQuote = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "QuoteList_1", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let cellModels = try! JSONDecoder().decode([QuoteDataModel].self, from: dataQuote)
        return cellModels
    }
    
    func build() -> UICollectionViewController {
        let cellModels = fetchInitialQuotes()
        let viewModel = MainScreenViewModel(quoteCellModels: cellModels)
        let layout = UICollectionViewFlowLayout.init()
        let mainvc = MainViewController.init(collectionViewLayout: layout)
        mainvc.viewModel = viewModel
        return mainvc
    }
}
