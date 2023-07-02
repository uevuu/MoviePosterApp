//
//  NetworkApiService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import Alamofire

// MARK: - NetworkApiService
final class NetworkApiService {
    private let baseURL = "https://kinopoiskapiunofficial.tech"
    private let apiKey = "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b"
    
    func sendRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            baseURL + endpoint,
            parameters: parameters,
            headers: HTTPHeaders(["X-API-KEY": apiKey])
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
