//
//  SummaryModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/10/21.
//

import Foundation


struct SummaryModel {
    let country: String
    let website: String
    let industry: String
    let sector: String
    let longBusinessSummary: String
    let fullTimeEmployees: Int
}

extension SummaryModel: Decodable {
    enum SummaryModelCodingKeys: String, CodingKey {
        case country = "country"
        case website = "website"
        case industry = "industry"
        case sector = "sector"
        case longBusinessSummary = "longBusinessSummary"
        case fullTimeEmployees = "fullTimeEmployees"
    }
    
    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: SummaryModelCodingKeys.self)
        country = try conatiner.decodeWrapper(key: .country, defaultValue: "No data")
        website = try conatiner.decodeWrapper(key: .website, defaultValue: "No data")
        industry = try conatiner.decodeWrapper(key: .industry, defaultValue: "No data")
        sector = try conatiner.decodeWrapper(key: .sector, defaultValue: "No data")
        longBusinessSummary = try conatiner.decodeWrapper(key: .longBusinessSummary, defaultValue: "No data")
        fullTimeEmployees = try conatiner.decodeWrapper(key: .fullTimeEmployees, defaultValue: 0)
    }
    
}
