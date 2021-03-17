//
//  CoordinateModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/6/21.
//

import Foundation


struct CoordinatesModel: Decodable {
    let items: [String: ItemModel]
}

struct ItemModel {
    
    var dateItem: String
    var openItem: Double
    var highItem: Double
    var lowItem: Double
    var closeItem: Double
    
}

extension ItemModel: Decodable {
    enum ItemModelCodingKeys: String, CodingKey {
        case date = "date"
        case open = "open"
        case high = "high"
        case low = "low"
        case close = "close"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: ItemModelCodingKeys.self)
        dateItem = try conatiner.decodeWrapper(key: .date, defaultValue: "No data")
        openItem = try conatiner.decodeWrapper(key: .open, defaultValue: 0.00)
        highItem = try conatiner.decodeWrapper(key: .high, defaultValue: 0.00)
        lowItem = try conatiner.decodeWrapper(key: .low, defaultValue: 0.00)
        closeItem = try conatiner.decodeWrapper(key: .close, defaultValue: 0.00)
    }
}
