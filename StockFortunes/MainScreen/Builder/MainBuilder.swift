//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/17/21.
//

import UIKit


protocol ModuleBuilder {
    typealias Listener = ([QuoteCellModel]) -> ()
    func build() -> UIViewController
    func fetchInitialPeers(symbol: String) -> [QuoteCellModel]
}

class MainBuilder: ModuleBuilder {
    func fetchInitialPeers(symbol: String = "AAPL") -> [QuoteCellModel] {
        let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "QuoteList_1", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let cellModels = try! JSONDecoder().decode([QuoteCellModel].self, from: data)
        return cellModels
    }
    
    func build() -> UIViewController {
        let cellModels = fetchInitialPeers()
        let viewModel = MainScreenViewModel(quoteCellModels: cellModels)
        let mainvc = MainViewController()
        mainvc.viewModel = viewModel
        return mainvc
    }
}
