//
//  QuoteCellModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

struct QuoteCellModel {
    var ticker: String? = ""
    var title: String? = ""
    
    var currency: String? = ""
    var currentPrice: Double? = 0.0
    var diffPrice: Double? = 0.0
    var changePercent: Double? = 0.0
    
    var favourite: Bool = false
    
    enum CurrencySymbol: String {
        case usd = "$"
        case rub = "₽"
    }
    
}

extension QuoteCellModel: Decodable {
    enum QuoteCellModelCodingKeys: String, CodingKey {
        case ticker = "symbol"
        case title = "shortName"
        
        case currency = "financialCurrency"
        case currentPrice = "regularMarketPrice"
        case diffPrice = "regularMarketChange"
        case changePercent = "regularMarketChangePercent"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: QuoteCellModelCodingKeys.self)
        ticker = try conatiner.decode(String.self, forKey: .ticker)
        title = try conatiner.decode(String.self, forKey: .title)
        
        currency = try conatiner.decode(String.self, forKey: .currency)
        currentPrice = try conatiner.decode(Double.self, forKey: .currentPrice)
        diffPrice = try conatiner.decode(Double.self, forKey: .diffPrice)
        changePercent = try conatiner.decode(Double.self, forKey: .changePercent)
    }
}

struct QuoteLogoModel {
    var logo: String?
}

extension QuoteLogoModel: Decodable {
    enum QuoteLogoModelCodingKeys: String, CodingKey {
        case logo = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: QuoteLogoModelCodingKeys.self)
        logo = try conatiner.decode(String.self, forKey: .logo)
    }
}
