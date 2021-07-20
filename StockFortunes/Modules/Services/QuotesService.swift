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
    
    func createQuoteListByOption(quoteListResponse: [Quote]?, option: QuoteListingOptions) -> QuotesProtocol? {
        print("creating quotelist")
        guard var quoteListResponse = quoteListResponse else {
            return nil
        }
        quoteListResponse[3].favourite = true
        quoteListResponse[5].favourite = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            quoteListResponse[7].favourite = true
//            print("219319031031093910")
//
//        }
        switch option {
        case .quotes:
            return QuotesMainListing(quotes: quoteListResponse.compactMap { quote in
                QuoteSnippetState.QuoteData(quote: quote)
            })
        case .favourites:
            return QuotesFavouriteListing(quotes: quoteListResponse.compactMap { quote in
                if quote.favourite {
                    return QuoteSnippetState.QuoteData(quote: quote)
                } else { return nil }
            })
        }
    }
}
