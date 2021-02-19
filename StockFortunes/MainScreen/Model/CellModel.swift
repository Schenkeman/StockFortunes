//
//  QuoteCellModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

struct QuoteCellModel: Codable {
    let logo: String?
    static var ticker: String?
    let title: String?
    
    let currency: String
    let currentPrice: Double
    let diffPrice: Double
    
    var favourite: Bool = false
    
    
}
