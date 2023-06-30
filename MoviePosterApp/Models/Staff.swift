//
//  Staff.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import Foundation

struct Staff: Codable {
    let staffId: Int
    let nameRu: String?
    let nameEn: String?
    let posterUrl: String
}
