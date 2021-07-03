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
    var quoteListResponse: [Quote]?
    var quotesListing: QuotesProtocol?

    var option: MainHeaderViewOptions = .quotes
    
    func viewDidLoad() {
        view?.showHUD()
        interactor?.loadQuotes()
    }
    
    func chooseTypeOfListing(option: MainHeaderViewOptions) {
        self.option = option
        createList()
    }
    
    func refresh() {
        interactor?.loadQuotes()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let quotesMainList = self.quotesListing, let quotesCount = quotesMainList.quotes?.count else {
            return 0
        }
        return quotesCount
    }
    
    func configureQuoteSnippet(indexPath: IndexPath) -> QuoteSnippetState.QuoteData? {
        switch self.option {
        case .quotes:
            return quotesListing?.quotes?[indexPath.row]
        case .favourites:
            return quotesListing?.quotes?[indexPath.row]
        }
    }

    func didSelectItemAt(index: Int) {
        interactor?.retrieveQuote(at: index)
    }
    
    func deselectItem(indexPath: IndexPath) {
        view?.deselectItem(indexPath: indexPath)
    }
    
    func didTapFavourite(ticker: String) {
        return
    }
    
    func createList() {
        guard var quoteListResponse = quoteListResponse else {
            return
        }
        quoteListResponse[3].favourite = true
        quoteListResponse[5].favourite = true
        switch self.option {
        case .quotes:
            quotesListing = QuotesMainListing(quotes: quoteListResponse.compactMap { quote in
                QuoteSnippetState.QuoteData(quote: quote)
            })
        case .favourites:
            quotesListing = QuotesFavouriteListing(quotes: quoteListResponse.compactMap { quote in
                if quote.favourite {
                    return QuoteSnippetState.QuoteData(quote: quote)
                } else { return nil }
            })
        }
    }
}

extension QuotesPresenter: InteractorToPresenterQuotesProtocol {
    func fetchQuotesSuccess(quoteResponseModel: QuoteListResponseModel) {
        self.quoteResponseModel = quoteResponseModel
        self.quoteListResponse = quoteResponseModel.quoteResponse.result
        createList()
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
