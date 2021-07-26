//
//  QuoteDetailPresenter.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 16.07.2021.
//

import Foundation

class QuoteDetailContainerPresenter: ViewToPresenterQuoteDetailProtocol {
    
    var view: PresenterToViewQuoteDetailProtocol? 
    var router: PresenterToRouterQuoteDetailContainerProtocol?
    
    func viewDidLoad() {
        return
    }
    
    func selectViewController(index: Int) {
        guard let option = DetailViewControllerOption(rawValue: index) else { return }
        view?.selectViewController(option: option)
        print(index)
        return
    }
    
    
}
