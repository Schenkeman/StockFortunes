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
    
    let dateFormatter = DateFormatter()
    
    init(newsItemModel: NewsItemModel) {
        self.title = newsItemModel.title
        self.itemDescription = newsItemModel.itemDescription
        self.link = newsItemModel.link
        
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: newsItemModel.pubDate)
        dateFormatter.dateFormat = "MMM d, h:mm a"
        self.pubDate = dateFormatter.string(from: date!)
    }
    
    
}
