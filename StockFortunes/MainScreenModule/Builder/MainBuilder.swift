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

//class MainBuilder: ModuleBuilder {
//    
//    func getStocksFromDB() -> Results<Stock> {
//        let initialTickersList = ["YNDX", "AAPL","GOOG","NFLX","T","TSLA","AMZN","MSFT","NVDA","INTC","PYPL","ADBE","VZ"]
//        var stocks = [Stock]()
//        if StocksDB.realm.objects(Stock.self).count != 0 {
//            for object in StocksDB.realm.objects(Stock.self) {
//                stocks.append(object)
//            }
//        } else {
//            try! StocksDB.realm.write {
//                for ticker in initialTickersList {
//                    let stock = Stock()
//                    stock.ticker = ticker
//                    stocks.append(stock)
//                }
//                StocksDB.realm.add(stocks)
//            }
//            
//        }
//        return StocksDB.realm.objects(Stock.self)
//    }
//    
//    func build() -> UICollectionViewController {
//        try! StocksDB.realm.write {
//            StocksDB.realm.deleteAll()
//        }
//        //        let stockModels = MockServer.fetchInitialStocks()
//        let items = getStocksFromDB()
//        let layout = UICollectionViewFlowLayout()
//        let mainvc = StocksListViewController.init(collectionViewLayout: layout)
//        mainvc.networkManager = NetworkManager()
//        mainvc.items = items
//        //        mainvc.mainStockCells = stockModels
//        return mainvc
//    }
//}
