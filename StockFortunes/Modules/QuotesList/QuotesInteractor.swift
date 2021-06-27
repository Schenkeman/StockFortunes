//
//  QuotesInteractor.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/6/21.
//

import Foundation

class QuotesInteractor: PresenterToInteractorQuotesProtocol {
    
    weak var presenter: InteractorToPresenterQuotesProtocol?
    var quotesResponseModel: QuoteListResponseModel?
    
    func loadQuotes() {
        QuotesService.shared.getQuotes { quotesResponseModel in
            self.quotesResponseModel = quotesResponseModel
            self.presenter?.fetchQuotesSuccess(quoteResponseModel: quotesResponseModel)
        }
    }
    
    func retrieveQuote(at index: Int) {
//        guard let quotes = self.quotes, quotes.indices.contains(index) else {
//            self.presenter?.getQuoteFailure()
//            return
//        }
//        self.presenter?.getQuoteSuccess(self.quotes![index])
    }
    
    
    
}
