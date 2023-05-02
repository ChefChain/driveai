//
//  APIService.swift
//  XCAChatGPT
//
//  Created by BotBaller on 2023-05-01.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    private init() {}

    private let apiKey = "your_api_key_here" // Replace this with your actual API key
    private let baseUrl = "https://api.autotrader.ca/dealer-api/v1"

    func fetchCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        let endpoint = "\(baseUrl)/cars"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]

        AF.request(endpoint, method: .get, headers: headers).validate().responseDecodable(of: [Car].self) { response in
            switch response.result {
            case .success(let cars):
                completion(.success(cars))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
