//
//  FilmInfoService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import Alamofire

// MARK: - FilmInfoService
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
