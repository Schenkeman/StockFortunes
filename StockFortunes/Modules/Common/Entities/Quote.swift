//
//  Quote.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/27/21.
//
import Foundation

struct QuoteResponseModel: Codable {
    let quoteResponse: QuoteResponse
}

// MARK: - regularmarketopenQuoteResponse
struct QuoteResponse: Codable {
    let result: [Quote]
    let error: JSONNull?
}

struct Quote: Codable {

    var ticker: String
    var title: String

    var currentPrice: Double
    var diffPrice: Double
    var changePercent: Double

    var favourite: Bool = false
    var timeAddedToFavourite: Date?

}

extension Quote {
    enum QuoteCodingKeys: String, CodingKey {
        case ticker = "symbol"
        case title = "shortName"

        case currentPrice = "regularMarketPrice"
        case diffPrice = "regularMarketChange"
        case changePercent = "regularMarketChangePercent"
    }

    init(from decoder: Decoder) throws {
        let conatiner = try decoder.container(keyedBy: QuoteCodingKeys.self)
        ticker = try conatiner.decodeWrapper(key: .ticker, defaultValue: "No data")
        title = try conatiner.decodeWrapper(key: .title, defaultValue: "No data")
        currentPrice = try conatiner.decodeWrapper(key: .currentPrice, defaultValue: 0.00)
        diffPrice = try conatiner.decodeWrapper(key: .diffPrice, defaultValue: 0.00)
        changePercent = try conatiner.decodeWrapper(key: .changePercent, defaultValue: 0.00)
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
