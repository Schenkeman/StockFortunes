//
//  QuotesInteractor.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/6/21.
//

import Foundation

class QuotesInteractor: PresenterToInteractorQuotesProtocol {
    
    weak var presenter: InteractorToPresenterQuotesProtocol?
    var quotes: [String]?
    
    func loadQuotes() {
//        QuoteService.shared.getQuotes(count: 6, success: { (code, quotes) in
//            self.quotes = quotes
//            self.presenter?.fetchQuotesSuccess(quotes: quotes)
//        }) { (code) in
//            self.presenter?.fetchQuotesFailure(errorCode: code)
//        }
    }
    
    func retrieveQuote(at index: Int) {
//        guard let quotes = self.quotes, quotes.indices.contains(index) else {
//            self.presenter?.getQuoteFailure()
//            return
//        }
//        self.presenter?.getQuoteSuccess(self.quotes![index])
    }
    
    
    
}
