//
//  MainViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

protocol MainScreenViewModelProtocol {
    typealias Listener = ([QuoteDataModel]) -> ()
    var quoteCellModels: [QuoteDataModel] { get set }
    var listener: Listener? { get set }
    init(quoteCellModels: [QuoteDataModel])
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    var listener: Listener?
//    var manager: NetworkManager = NetworkManager()
    var quoteCellModels: [QuoteDataModel] {
        didSet {
            listener?(quoteCellModels)
        }
    }
    
    
    required init(quoteCellModels: [QuoteDataModel]) {
        self.quoteCellModels = quoteCellModels
        
    }
}
