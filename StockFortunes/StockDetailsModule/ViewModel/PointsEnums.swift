//
//  PointsEnums.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/20/21.
//

import Foundation

enum DataGranularityEnum: String {
    case h1 = "1h"
    case d1 = "1d"
    case wk1 = "1wk"
    case mo1 = "1mo"
    case mo3 = "3mo"
}

enum EpochTypeRequest: Int, CaseIterable {
    case day
    case week
    case month
    case sixMonth
    case oneYear
    
    
    var description: String {
        switch self {
        case .day: return "1h"
        case .week: return "1d"
        case .month: return "1wk"
        case .sixMonth: return "1mo"
        case .oneYear: return "3mo"
        
        }
    }
}

enum EpochType: Int, CaseIterable {
    case day
    case week
    case month
    case sixMonth
    case oneYear
    
    
    var description: String {
        switch self {
        case .day: return "D"
        case .week: return "W"
        case .month: return "M"
        case .sixMonth: return "6M"
        case .oneYear: return "1Y"
        
        }
    }
}
