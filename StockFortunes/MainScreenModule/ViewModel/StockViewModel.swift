//
//  MainViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

protocol StocksListViewModelProtocol {
    typealias Listener = ([StockModel]) -> ()
    var stockModels: [StockModel] { get set }
    var listener: Listener? { get set }
    init(stockModels: [StockModel])
}

final class StocksListViewModel: StocksListViewModelProtocol {
    
    //    var manager: NetworkManager = NetworkManager()
    var listener: Listener?
    var stockModels: [StockModel] {
        didSet {
            listener?(stockModels)
        }
    }
    required init(stockModels: [StockModel]) {
        self.stockModels = stockModels
    }
}

final class StockViewModel {
    var ticker: String
    var title: String
    var currentPrice: Double
    var diffPrice: Double
    var changePercent: Double
    
    var favourite: Bool
    var timeAddedToFavourite: Date?
    
    init(stockModel: StockModel) {
        self.ticker = stockModel.ticker
        self.title = stockModel.title
        self.currentPrice = stockModel.currentPrice
        self.diffPrice = stockModel.diffPrice
        self.changePercent = stockModel.changePercent
        self.favourite = stockModel.favourite
    }
}
