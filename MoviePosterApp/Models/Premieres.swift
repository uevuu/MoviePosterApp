import Foundation

struct Premieres: Codable {
    let total: Int
    let items: [Premiere]
}

struct Premiere: Codable {
    let filmId: Int
    let nameRu: String
    let genres: [Genre]
    let data: String
    let posterURLPreview: String
    
    enum CodingKeys: String, CodingKey {
        case filmId = "kinopoiskId"
        case nameRu
        case genres
        case data = "premiereRu"
        case posterURLPreview = "posterUrlPreview"
    }
    
}
