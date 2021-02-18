//
//  String+Extensions.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/18/21.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
