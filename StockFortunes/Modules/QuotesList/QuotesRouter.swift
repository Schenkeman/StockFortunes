//
//  QuotesRouter.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/6/21.
//

import Foundation
import UIKit

class QuotesRouter: PresenterToRouterQuotesProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        print("QuotesRouter creates the Quotes module.")
        let viewController = QuotesViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterQuotesProtocol & InteractorToPresenterQuotesProtocol = QuotesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = QuotesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = QuotesInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        viewController.presenter?.selectedOption = .quotes
        
        return navigationController
    }

    // MARK: - Navigation
    func pushToQuoteDetail(on view: PresenterToViewQuotesProtocol, with quote: Quote) {
        let quoteDetailContainerViewController = QuoteDetailContainerRouter.createModule(with: quote)

        let viewController = view as! QuotesViewController
        viewController.navigationController?
            .pushViewController(quoteDetailContainerViewController, animated: true)
    }
}
