//
//  Mocks.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/14/21.
//

import Foundation


class MockServer {
    static func fetchInitialStocks() -> [StockModel] {
        let stockData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "initialStocks", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let stockModels = try! JSONDecoder().decode([StockModel].self, from: stockData)
        return stockModels
    }
    
    static func searchStocks(file: String) -> [StockModel] {
        let stockData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_Search", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let stockDataModel = try! JSONDecoder().decode([StockModel].self, from: stockData)
        return stockDataModel
    }
    
    static func fetchSummary(file: String) -> SummaryModel {
        let summaryData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_Summary", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let summaryModel = try! JSONDecoder().decode(SummaryModel.self, from: summaryData)
        return summaryModel
    }
    
    static func fetchNews(file: String) -> NewsModel {
        let newsData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_News", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let newsModel = try! JSONDecoder().decode(NewsModel.self, from: newsData)
        return newsModel
    }
    
    static func fetchPoints(file: String, epoch: EpochTypeRequest) -> PointsModel {
        let pointsData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_\(epoch.description)", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let pointsModel = try! JSONDecoder().decode(PointsModel.self, from: pointsData)
        return pointsModel
    }
}
