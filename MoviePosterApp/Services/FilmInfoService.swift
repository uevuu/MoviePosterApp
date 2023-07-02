//
//  FilmInfoService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import Alamofire

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

final class FilmInfoService {
    private let networkService = NetworkApiService()
    
    func getFilmInfo(filmId: Int, completion: @escaping (Result<FilmInfo, Error>) -> Void) {
        networkService.sendRequest(
            endpoint: "/api/v2.2/films/\(filmId)",
            completion: completion
        )
    }
    
    func getStaffFromFilm(filmId: Int, completion: @escaping (Result<[Staff], Error>) -> Void) {
        networkService.sendRequest(
            endpoint: "/api/v1/staff",
            parameters: [
                "filmId": filmId
            ],
            completion: completion
        )
    }
}
