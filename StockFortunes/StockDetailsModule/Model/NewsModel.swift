//
//  NewsModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/13/21.
//

import Foundation

struct NewsModel: Decodable {
    let item: [NewsItemModel]
}

struct NewsItemModel {
    
    var title: String
    var itemDescription: String
    var link: String
    var pubDate: String
}

extension NewsItemModel: Decodable {
    enum NewsItemModelCodingKeys: String, CodingKey {
        case title = "title"
        case itemDescription = "description"
        case link = "link"
        case pubDate = "pubDate"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: NewsItemModelCodingKeys.self)
        title = try conatiner.decodeWrapper(key: .title, defaultValue: "No data")
        itemDescription = try conatiner.decodeWrapper(key: .itemDescription, defaultValue: "No data")
        link = try conatiner.decodeWrapper(key: .link, defaultValue: "No data")
        pubDate = try conatiner.decodeWrapper(key: .pubDate, defaultValue: "No data")
    }
}

