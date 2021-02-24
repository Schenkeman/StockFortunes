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
//    func fetchInitialPeers(symbol: String = "AAPL") -> [String] {
//        let dataPeers = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "PeersList", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
//        let peersList = try! JSONDecoder().decode(PeersList.PeersList.self, from: dataPeers)
//        return peersList
//    }
    
    func fetchInitialQuotes(symbol: String = "AAPL") -> [QuoteDataModel] {
        let dataQuote = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "QuoteList_1", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let cellModels = try! JSONDecoder().decode([QuoteDataModel].self, from: dataQuote)
        return cellModels
    }
    
    func build() -> UICollectionViewController {
        let cellModels = fetchInitialQuotes()
        let viewModel = MainScreenViewModel(quoteCellModels: cellModels)
//        let layout = StickyHeaderLayout.init()
        let layout = UICollectionViewFlowLayout.init()
        let mainvc = MainViewController.init(collectionViewLayout: layout)
        mainvc.viewModel = viewModel
        return mainvc
    }
}
