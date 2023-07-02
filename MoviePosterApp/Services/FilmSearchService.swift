//
//  FilmSearchService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import Alamofire

// MARK: - FilmSearchService
final class FilmSearchService {
    private let networkService = NetworkApiService()
    
    func getFilmsByKeyword(
        _ keyword: String,
        page: Int,
        completion: @escaping (Result<KeyWordSearchResult, Error>) -> Void
    ) {
        networkService.sendRequest(
            endpoint: "/api/v2.1/films/search-by-keyword",
            parameters: [
                "keyword": keyword,
                "page": page
            ],
            completion: completion
        )
    }
}
