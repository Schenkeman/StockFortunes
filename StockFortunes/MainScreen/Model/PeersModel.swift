//
//  PeersModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/19/21.
//

import Foundation


struct PeersList {
    var peers: [String] = []
}

extension PeersList: Decodable  {
    typealias PeersList = [String]
}
