//
//  FilterHeaderViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/23/21.
//

import UIKit

enum HeaderType: String {
    case mainViewHeader
    case quoteViewHeader
}

enum QuoteListingOptions: Int, CaseIterable {
    case quotes
    case favourites
    
    var description: String {
        switch self {
        case .quotes: return "Quotes"
        case .favourites: return "Favourites"
        }
    }
}

enum DetailViewControllerOption: Int, CaseIterable {
    case chart
    case summary
    case news
    
    var description: String {
        switch self {
        case .chart: return "Chart"
        case .summary: return "Summary"
        case .news: return "News"
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

