//
//  Films.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import Foundation

struct Films: Codable {
    let pagesCount: Int
    let films: [Film]
}

struct Film: Codable {
    let filmId: Int
    let rating: String?
    let posterUrlPreview: String
}

struct FilmInfo: Codable, Equatable {
    let kinopoiskId: Int
    let nameRu: String?
    let coverUrl: String?
    let year: Int?
    let filmLength: Int?
    let description: String?
    let ratingImdb: Double?
    let posterUrl: String
    let posterUrlPreview: String
    let isTicketsAvailable: Bool
    
    static func == (lhs: FilmInfo, rhs: FilmInfo) -> Bool {
        return lhs.kinopoiskId == rhs.kinopoiskId
    }
}
