//
//  QuoteDetailRouter.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 16.07.2021.
//

import Foundation
import UIKit

class QuoteDetailContainerRouter: PresenterToRouterQuoteDetailContainerProtocol {
    
    // MARK: Static methods
    static func createModule(with quote: Quote) -> UIViewController {
        print("QuoteDetailRouter creates the QuoteDetail module.")
        let viewController = QuoteDetailContainerViewController(with: quote)
        
//        let presenter: ViewToPresenterQuoteDetailProtocol & InteractorToPresenterQuoteDetailProtocol = QuoteDetailPresenter()
        
//        viewController.presenter = presenter
//        viewController.presenter?.router = QuoteDetailRouter()
//        viewController.presenter?.view = viewController
//        viewController.presenter?.interactor = QuoteDetailInteractor()
//        viewController.presenter?.interactor?.quote = quote
//        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}

