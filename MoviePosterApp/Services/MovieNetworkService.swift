//
//  MovieNetworkService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import Alamofire

final class MovieNetworkService {
    private let baseURL = "https://kinopoiskapiunofficial.tech"
    private let apiKey = "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b"
    
    private func sendRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters,
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
    
    func getPremieres(completion: @escaping (Result<Premieres, Error>) -> Void) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMMM"
        let currentMonth = dateFormatter.string(from: currentDate)
        dateFormatter.dateFormat = "yyyy"
        let currentYear = Int(dateFormatter.string(from: currentDate))
        sendRequest(
            endpoint: "/api/v2.2/films/premieres",
            parameters: [
                "year": currentYear ?? 2023,
                "month": currentMonth
            ],
            completion: completion
        )
    }
    
    func getTopFilms(
        topType: TypeOfFilmCollection,
        page: Int,
        completion: @escaping (Result<Films, Error>) -> Void
    ) {
        sendRequest(
            endpoint: "/api/v2.2/films/top",
            parameters: [
                "type": topType.rawValue,
                "page": page
            ],
            completion: completion
        )
    }
}

enum TypeOfFilmCollection: String {
    case popular = "TOP_100_POPULAR_FILMS" // max 20 page (in response 35)
    case await = "TOP_AWAIT_FILMS"
    case best = "TOP_250_BEST_FILMS"
}
