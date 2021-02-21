//
//  Decodable+Extensions.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/21/21.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
        where T : Decodable {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
}


