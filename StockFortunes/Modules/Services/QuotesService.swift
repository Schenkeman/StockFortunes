//
//  QuotesService.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/27/21.
//

import Foundation

class QuotesService {

    static let shared = QuotesService()

    func getQuotes(completion: @escaping(_ : QuoteListResponseModel) -> ()){
        let quotesResponseData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "get_quotes", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let quotesModel = try! JSONDecoder().decode(QuoteListResponseModel.self, from: quotesResponseData)
        completion(quotesModel)
    }
}
