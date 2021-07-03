//
//  QuotesDictionary.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 7/2/21.
//

import Foundation

protocol QuotesProtocol {
    var quotes: [QuoteSnippetState.QuoteData]? { get set }
}

struct QuotesMainListing: QuotesProtocol {
    var quotes: [QuoteSnippetState.QuoteData]?
}


struct QuotesFavouriteListing: QuotesProtocol {
    var quotes: [QuoteSnippetState.QuoteData]?
}



