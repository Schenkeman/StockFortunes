//
//  QuoteDetailProtocols.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 16.07.2021.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewQuoteDetailProtocol: AnyObject {
//    func onGetImageFromURLSuccess(_ quote: String, character: String, image: UIImage)
//    func onGetImageFromURLFailure(_ quote: String, character: String)
    func removeInactiveViewController(inactiveViewController: UIViewController?)
    func updateActiveViewController()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterQuoteDetailProtocol: AnyObject {
//    var view: PresenterToViewQuoteDetailProtocol? { get set }
//    var interactor: PresenterToInteractorQuoteDetailProtocol? { get set }
    var router: PresenterToRouterQuoteDetailContainerProtocol? { get set }

    func viewDidLoad()
    func selectViewController(_ option: StockControllerOption)
    
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorQuoteDetailProtocol: AnyObject {
//    var presenter: InteractorToPresenterQuoteDetailProtocol? { get set }
//
//    var quote: Quote? { get set }
//
//    func getImageDataFromURL()
    
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterQuoteDetailProtocol: AnyObject {
//    func getImageFromURLSuccess(quote: Quote, data: Data?)
//    func getImageFromURLFailure(quote: Quote)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterQuoteDetailContainerProtocol: AnyObject {
    static func createModule(with quote: Quote) -> UIViewController
}

