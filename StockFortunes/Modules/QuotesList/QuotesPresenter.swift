//
//  QuotesPresenter.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 5/25/21.
//

import Foundation
import PKHUD

class QuotesPresenter: ViewToPresenterQuotesProtocol {
    
    //MARK:- Properties
    
    weak var view: PresenterToViewQuotesProtocol?
    var interactor: PresenterToInteractorQuotesProtocol?
    var router: PresenterToRouterQuotesProtocol?

    var quoteResponseModel: QuoteListResponseModel?
    var quotesList: [Quote]?
    var quotesStrings: [String]?
    
    func viewDidLoad() {
        view?.showHUD()
        interactor?.loadQuotes()
    }
    
    func refresh() {
        interactor?.loadQuotes()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let quoteResponseModel = self.quoteResponseModel else {
            return 0
        }

        return quoteResponseModel.quoteResponse.result.count
    }

    func configureQuoteSnippet(indexPath: IndexPath) -> QuoteSnippetState.QuoteData? {
        guard let quoteResponseModel = self.quoteResponseModel else {
            return nil
        }
        let quoteData = quoteResponseModel.quoteResponse.result[indexPath.row]
        let quoteDataModel = QuoteSnippetState.QuoteData(quote: quoteData)
        return quoteDataModel
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        guard let quotesStrings = self.quotesStrings else {
            return nil
        }
        
        return quotesStrings[indexPath.row]
    }

    
    func didSelectRowAt(index: Int) {
        interactor?.retrieveQuote(at: index)
    }
    
    func deselectRowAt(index: Int) {
//        view?.deselectRowAt(row: index)
    }
}

extension QuotesPresenter: InteractorToPresenterQuotesProtocol {
    func fetchQuotesSuccess(quoteResponseModel: QuoteListResponseModel) {
        self.quoteResponseModel = quoteResponseModel
        view?.hideHUD()
        view?.onFetchQuotesSuccess()
    }
    
    func fetchQuotesFailure(errorCode: Int) {
        view?.hideHUD()
        view?.onFetchQuotesFailure(error: "Couldn't fetch quotes: \(errorCode)")
    }

    func getQuoteSuccess(_ quote: Quote) {
        router?.pushToQuoteDetail(on: view!, with: quote)
    }

    func getQuoteFailure() {
        view?.hideHUD()
        print("Couldn't retrieve quote by index")
    }
}
