//
//  MainViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

protocol MainScreenViewModelProtocol {
    typealias Listener = ([QuoteCellModel]) -> ()
    var quoteCellModels: [QuoteCellModel] { get set }
    var listener: Listener? { get set }
    init(quoteCellModels: [QuoteCellModel])
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    var listener: Listener?
//    var manager: NetworkManager = NetworkManager()
    var quoteCellModels: [QuoteCellModel] {
        didSet {
            listener?(quoteCellModels)
        }
    }
    var peersListModel: PeersList?
    
    required init(quoteCellModels: [QuoteCellModel]) {
        self.quoteCellModels = quoteCellModels
    }
    
//    func fetchInitialPeers(symbol: String = "AAPL", listener: Listener?) {
//        guard let listener = listener else { return }
//        self.listener = listener
//        manager.getPeersQuotes(symbols: symbol) { [weak self] (peers, error) in
//            guard let self = self else { return }
//            guard let peers = peers else { return }
//            self.manager.getStockQuotes(symbols: peers) { [weak self] (cellModels, error) in
//                guard let self = self else { return }
//                guard let cellModels = cellModels else { return }
//                self.listener?(cellModels)
//            }
//        }
//        let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "QuoteList_1", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
//        let cellModels = try! JSONDecoder().decode([QuoteCellModel].self, from: data)
//        self.listener?(cellModels)
//    }
    
    
}
