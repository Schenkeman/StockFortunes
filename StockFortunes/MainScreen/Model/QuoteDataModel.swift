//
//  QuoteCellModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

struct QuoteDataModel {
    
    var ticker: String?
    var title: String?
    
    var currentPrice: Double?
    var diffPrice: Double? = 0.0
    var changePercent: Double? = 0.0
    
    var favourite: Bool = false
    var timeAddedToFavourite: Date?
    
}

extension QuoteDataModel: Decodable {
    enum QuoteDataModelCodingKeys: String, CodingKey {
        case ticker = "symbol"
        case title = "shortName"
        
        case currentPrice = "regularMarketPrice"
        case diffPrice = "regularMarketChange"
        case changePercent = "regularMarketChangePercent"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: QuoteDataModelCodingKeys.self)
        ticker = try conatiner.decodeWrapper(key: .ticker, defaultValue: "No data")
        title = try conatiner.decodeWrapper(key: .title, defaultValue: "No data")
        currentPrice = try conatiner.decodeWrapper(key: .currentPrice, defaultValue: 0.00)
        diffPrice = try conatiner.decodeWrapper(key: .diffPrice, defaultValue: 0.00)
        changePercent = try conatiner.decodeWrapper(key: .changePercent, defaultValue: 0.00)
    }
}
