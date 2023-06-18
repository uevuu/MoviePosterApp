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
    let nameRu: String?
    let nameEn: String?
    let year: String?
    let filmLength: String?
    let rating: String?
    let posterUrl: String
    let posterUrlPreview: String
}
