//
//  PeersRequestModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/18/21.
//

import Foundation

class PeersRequestModel: RequestModel {
    
    // MARK: - Properties
    private var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    override var path: String {
        return Constant.ServiceConstant.peers
    }
    
    override var parameters: [String : Any?] {
        return [
            "symbol": symbol
        ]
    }
    override var query: [String : Any?] {
        return [
            "token": "sandbox_c0lsj8f48v6r1vcseilg"
        ]
    }
}
