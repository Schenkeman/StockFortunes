//
//  NewsViewModel.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/13/21.
//

import Foundation

class NewsViewModel {
    var newsModel: NewsModel!
    
    let title: String
    let itemDescription: String
    let link: String
    let pubDate: String
    
    
    
    init(newsItemModel: NewsItemModel) {
        self.title = newsItemModel.title
        self.itemDescription = newsItemModel.itemDescription
        self.link = newsItemModel.link
        self.pubDate = newsItemModel.pubDate
    }
    
    
}
