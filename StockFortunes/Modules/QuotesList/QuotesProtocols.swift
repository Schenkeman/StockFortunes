//
//  QuotesProyo.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 5/24/21.
//

import Foundation
import UIKit

//MARK:- View Output
protocol PresenterToViewQuotesProtocol: AnyObject {
    
    func onFetchQuotesSuccess()
    func onFetchQuotesFailure(error: String)

    func showHUD()
    func hideHUD()
    
    func deselectItem(indexPath: IndexPath)
    func refreshCellsState()
}

//MARK:- View Input
protocol ViewToPresenterQuotesProtocol: AnyObject {
    
    var view: PresenterToViewQuotesProtocol? { get set }
    var interactor: PresenterToInteractorQuotesProtocol? { get set }
    var router: PresenterToRouterQuotesProtocol? { get set }
    
    var selectedOption: QuoteListingOptions! { get set }
    
    func viewDidLoad()
    func refresh()
    
    func numberOfRowsInSection(isFiltering: Bool) -> Int
    func configureQuoteSnippet(indexPath: IndexPath, isFiltering: Bool) -> QuoteSnippetState.QuoteData?
    
    func didSelectItemAt(index: Int)
    func deselectItem(indexPath: IndexPath)
    
    func didTapFavourite(ticker: String)
    func selectTypeOfListing(option: QuoteListingOptions)
    func didSelectOption(index: Int)
    
    
    func filterContentForSearchText(_ searchText: String)
}

//MARK:- Interactor Input
protocol PresenterToInteractorQuotesProtocol: AnyObject {
    var presenter: InteractorToPresenterQuotesProtocol? { get set }
    
    func loadQuotes()
    func retrieveQuote(at: Int)
}

//MARK:- Interactor Output
protocol InteractorToPresenterQuotesProtocol: AnyObject {
    func fetchQuotesSuccess(quoteResponseModel: QuoteListResponseModel)
    func fetchQuotesFailure(errorCode: Int)

    func getQuoteSuccess(_ quote: Quote)
    func getQuoteFailure()
}

//MARK:- Router Input
protocol PresenterToRouterQuotesProtocol: AnyObject {
    static func createModule() -> UINavigationController
    
    func pushToQuoteDetail(on view: PresenterToViewQuotesProtocol, with quote: Quote)
    
}


