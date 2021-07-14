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
    
    var selectedOption: QuoteListingOptions!
    
    var quoteResponseModel: QuoteListResponseModel?
    var quoteListResponse: [Quote]?
    var quotesListing: QuotesProtocol?
    
    var filteredQuotes: [Quote]?
    
    func viewDidLoad() {
        view?.showHUD()
        interactor?.loadQuotes()
    }
    
    func chooseTypeOfListing(option: QuoteListingOptions) {
        selectedOption = option
        self.quotesListing = QuotesService.shared.createQuoteList(quoteListResponse: quoteListResponse,
                                                                  option: selectedOption)
        view?.refreshCellsState()
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
        switch self.selectedOption {
        case .quotes:
            return quotesListing?.quotes?[indexPath.row]
        case .favourites:
            return quotesListing?.quotes?[indexPath.row]
        case .none:
            return nil
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
    
    func didSelectOption(index: Int) {
        guard let option = QuoteListingOptions(rawValue: index) else { return }
        chooseTypeOfListing(option: option)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        guard let quoteListResponse = quoteListResponse else { return }
        filteredQuotes = quoteListResponse.filter { quote in
            return quote.ticker.lowercased().contains(searchText.lowercased())
        }
        view?.refreshCellsState()
    }
}

extension QuotesPresenter: InteractorToPresenterQuotesProtocol {
    func fetchQuotesSuccess(quoteResponseModel: QuoteListResponseModel) {
        self.quoteResponseModel = quoteResponseModel
        self.quoteListResponse = quoteResponseModel.quoteResponse.result
        self.quotesListing = QuotesService.shared.createQuoteList(quoteListResponse: quoteListResponse,
                                                                  option: selectedOption)
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
