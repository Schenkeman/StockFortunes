//
//  MainViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

protocol MainScreenViewModelProtocol {
    
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    typealias Listener = ([QuoteCellModel]) -> ()
    var manager: NetworkManager = NetworkManager()
    var quoteCellModel: QuoteCellModel?
    var peersListModel: PeersList? 
    
    
    var listener: Listener?
    
    func fetchInitialPeers(symbol: String = "AAPL", listener: Listener?) {
        self.listener = listener
        manager.getPeersQuotes(symbols: symbol) { [weak self] (peers, error) in
            guard let self = self else { return }
            guard let peers = peers else { return }
            self.manager.getStockQuotes(symbols: peers) { [weak self] (cellModels, error) in
                guard let self = self else { return }
                guard let cellModels = cellModels else { return }
                self.listener?(cellModels)
            }
        }
    }
    
    
}
