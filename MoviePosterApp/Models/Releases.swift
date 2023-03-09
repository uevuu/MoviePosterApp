import Foundation

struct Releases: Codable {
    let total: Int
    let films: [Realease]
    
    enum CodingKeys: String, CodingKey {
        case total
        case films = "releases"
    }
}

struct Realease: Codable {
    
    let filmId: Int
    let nameRu: String
    let genres: [Genre]
    let rating: Double?
    let posterURLPreview: String
    
    enum CodingKeys: String, CodingKey {
        case filmId
        case nameRu
        case genres
        case rating
        case posterURLPreview = "posterUrlPreview"
    }
}

