//
//  MainBuilder.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/17/21.
//

import UIKit


protocol ModuleBuilder {
    typealias Listener = ([StockModel]) -> ()
    func build() -> UICollectionViewController
}

class MainBuilder: ModuleBuilder {
    
    func build() -> UICollectionViewController {
        let stockModels = MockServer.fetchInitialStocks()
        let viewModel = StocksListViewModel(stockModels: stockModels)
        let layout = UICollectionViewFlowLayout()
        let mainvc = StocksListViewController.init(collectionViewLayout: layout)
        mainvc.stockModels = stockModels
        return mainvc
    }
}
