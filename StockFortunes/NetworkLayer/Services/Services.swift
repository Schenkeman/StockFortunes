//
//  Services.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/18/21.
//

import Foundation

class Services {
    
    class func getPeers(symbol: String, completion: @escaping(Swift.Result<PeersResponseModel.PeersList, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: PeersRequestModel(symbol: symbol)) { (result) in
            completion(result)
        }
    }
}
