//
//  StockDB.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/23/21.
//

import Foundation
import RealmSwift

class Stock: Object {
    @objc dynamic var ticker = ""
    @objc dynamic var favourite = false
    @objc dynamic var timeAddedToFav = Date()
}

class StocksDB {
    static var realm = try! Realm()
    
    static func addStock(stockData: StockModel, index: Int) {
        let stockItem = Stock()
        stockItem.ticker = stockData.ticker
        stockItem.favourite = stockData.favourite
        if let time = stockData.timeAddedToFavourite {
            stockItem.timeAddedToFav = time
        }
        try! StocksDB.realm.write {
            StocksDB.realm.add(stockItem)
        }
        let tickerItem = StocksDB.realm.objects(Stock.self)[index].ticker
        let favItem = StocksDB.realm.objects(Stock.self)[index].favourite
        print(tickerItem)
        print(favItem)
    }
    
    static func removeStock(index: Int) {
        let objectToDelete = StocksDB.realm.objects(Stock.self)[index]
        try! StocksDB.realm.write {
            StocksDB.realm.delete(objectToDelete)
        }
        
        print("deleted")
        print(StocksDB.realm.objects(Stock.self).count)
    }
    
}
