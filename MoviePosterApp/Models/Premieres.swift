//
//  Premieres.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import Foundation

struct Premieres: Codable {
    let total: Int
    let items: [Premiere]
}

struct Premiere: Codable {
    let kinopoiskId: Int
    let nameRu: String?
    let nameEn: String?
    let premiereRu: String
    let posterUrl: String
    let posterUrlPreview: String

}
