//
//  FinhubService.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

struct FinhubService {
    
    
    static func fetch() {
        let string = "https://finnhub.io/api/v1/quote?symbol=AAPL&token=sandbox_c0lsj8f48v6r1vcseilg"
        let url = URL(string: string)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()
    }
}
