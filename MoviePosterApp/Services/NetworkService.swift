//
//  NetworkService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 21.04.2023.
//

//import Alamofire
//
//class NetworkService {
//    private let baseURL = "https://kinopoiskapiunofficial.tech/"
//    private let API_KEY = "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b"
//
//    func sendRequest<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
//        AF.request(
//            baseURL + endpoint,
//            headers: HTTPHeaders([" X-API-KEY": API_KEY])
//        )
//        .response { response in
//            guard let data = response.data else {
//                if let error = response.error {
//                    completion(.failure(error))
//                }
//                return
//            }
//            do {
//                let result = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(result))
//            } catch let error {
//                completion(.failure(error))
//            }
//        }
//    }
//}
