//
//  APIManager.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//
import Foundation
import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

final class APIManager {
    
    static let shared = APIManager()
    private init () {}
    
    
    
    func gethUserHoldingDetails(completion : @escaping (Result<UserHoldingsResponse,DataError>) -> Void ){
        guard let url = URL(string: Constant.API.userHoldingDetailURL) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse ,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let userHoldingsResponse = try JSONDecoder().decode(UserHoldingsResponse.self, from: data)
                completion(.success(userHoldingsResponse))
                
            }catch{
                completion(.failure(.network(error)))
            }
            
            
        }.resume()
        
    }
}
