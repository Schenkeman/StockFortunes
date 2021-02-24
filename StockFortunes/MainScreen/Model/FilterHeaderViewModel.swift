//
//  FilterHeaderViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/23/21.
//

import Foundation
import UIKit

enum HeaderFilterOptions: Int, CaseIterable {
    case stocks
    case favourites
    
    var description: String {
        switch self {
        case .stocks: return "Stocks"
        case .favourites: return "Favourites"
        }
    }
}

struct HeaderFilterViewModel {
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(
            string: "\(value)",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedTitle.append(NSAttributedString(
            string: " \(text)",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
    
}

