//
//  SummaryViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/11/21.
//

import Foundation
import UIKit

class SummaryViewModel {
    
    let summaryModel: SummaryModel!
        
    let country: String
    let website: String
    let industry: String
    let sector: String
    let longBusinessSummary: String
    let fullTimeEmployees: Int
    
    init(model: SummaryModel) {
        self.summaryModel = model
        self.country = summaryModel.country
        self.website = summaryModel.website
        self.industry = summaryModel.industry
        self.sector = summaryModel.sector
        self.longBusinessSummary = summaryModel.longBusinessSummary
        self.fullTimeEmployees = summaryModel.fullTimeEmployees
    }
    
    
}
