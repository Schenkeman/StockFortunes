//
//  ServiceManager.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/18/21.
//

import Foundation

class ServiceManager {
    
    // MARK: - Properties
    public static let shared: ServiceManager = ServiceManager()
    
    public var baseURL: String = "https://finnhub.io/api/v1"
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest(request: RequestModel, completion: @escaping(Swift.Result<PeersResponseModel.PeersList, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }

        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            guard let data = data else {
//                guard var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
//                    let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
//                    LogManager.err(error)
//                    completion(Result.failure(error))
                    return
                }
                
//                responseModel.rawData = data
//                responseModel.request = request
                
//                if request.isLoggingEnabled.1 {
//                    LogManager.res(responseModel)
//                }
            guard var resp = try? JSONDecoder().decode(PeersResponseModel.PeersList.self, from: data) else {
                return
            }
//                if responseModel.isSuccess, let data = responseModel.data {
            completion(Result.success(resp))
//                } else {
//                    completion(Result.failure(ErrorModel.generalError()))
//                }
            }.resume()
            
        }
        
    }

