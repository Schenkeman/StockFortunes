//
//  NetworkManager.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/19/21.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum ServiceApiKey: String {
    case finhubSandbox = "sandbox_c0lsj8f48v6r1vcseilg"
    case finhubAPI = "c0lsj8f48v6r1vcseil0"
    case mboubAPI = "TArxUzv0sspX2SgYxlMud5GWOVXg3cBUUSDCbtz3N7fICh9HihZtVJFBDU9o"
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    let mboumRouter = Router<MboumApi>()
    let finhubRouter = Router<FinhubApi>()
    
    func getStockQuotes(symbols: [String], completion: @escaping (_ quote: [QuoteCellModel]?,_ error: String?)->()){
        let stringSymbols = symbols.joined(separator: ",")
        mboumRouter.request(.quotes(symbols: stringSymbols)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode([QuoteCellModel].self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getPeersQuotes(symbols: String, completion: @escaping (_ peers: [String]?,_ error: String?)->()){
        finhubRouter.request(.peers(symbols: symbols)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PeersList.PeersList.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
//    func getFakeData<T:Decodable>(jsonName: String, decodableClass: T, completion: @escaping (Decodable) -> ()) {
//        let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: jsonName, ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
//        let model = try! JSONDecoder().decode([decodableClass].self as! T.Type, from: data)
//        completion(model)
//    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
