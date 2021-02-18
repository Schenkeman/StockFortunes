//
//  FinhubService.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import Foundation

struct FinhubService {
    
    enum RequestEndpoint {
        case peers
    }
    
    enum RequestToken {
        case apiKey
        case sandbox
    }
    
    mutating func configureRequest(endPoint: RequestEndpoint, token: RequestToken) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
        components.path = "/api/v1/stock"
        
        switch endPoint {
        case .peers:
            components.queryItems?.append(URLQueryItem(name: "query", value: "swift ios"))
        default:
            <#code#>
        }
        
        let queryItemToken = URLQueryItem(name: "token", value: "12345")
        
        
        
    }
}



