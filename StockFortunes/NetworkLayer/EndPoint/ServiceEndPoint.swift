//
//  ServiceEndPoint.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/19/21.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case dev
    case production
    case staging
}

public enum MboumApi {
    case stocks(tickers: String)
    case chartData(ticker: String, epochType: EpochTypeRequest)
    case request
}

extension MboumApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://mboum.com/api/v1/"
        case .dev: return ""
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "qu/quote"
        case .chartData:
            return "hi/history"
        case .request:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .stocks(let symbols):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["symbol": symbols,
                                                      "apikey": ServiceApiKey.mboubAPI.rawValue
                                      ])
        case .chartData(let ticker, let epochType):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["symbol": ticker,
                                                      "interval": epochType.description,
                                                      "diffandsplits": true,
                                                      "apikey": ServiceApiKey.mboubAPI.rawValue
                                      ])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

//public enum FinhubApi {
//    case peers(symbols: String)
//    case request
//    
//}

//extension FinhubApi: EndPointType {
//
//    var environmentBaseURL : String {
//        switch NetworkManager.environment {
//        case .production: return "https://finnhub.io/api/v1/"
//        case .dev: return ""
//        case .qa: return ""
//        case .staging: return ""
//        }
//    }
//
//    var baseURL: URL {
//        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//
//    var path: String {
//        switch self {
//        case .peers:
//            return "stock/peers"
//        case .request:
//            return ""
//        }
//    }
//
//    var httpMethod: HTTPMethod {
//        return .get
//    }
//
//    var task: HTTPTask {
//        switch self {
//        case .peers(let symbols):
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["symbol":symbols,
//                                                      "token":ServiceApiKey.finhubSandbox.rawValue])
//        default:
//            return .request
//        }
//    }
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//}
//
//
//
