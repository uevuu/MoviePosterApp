import Foundation

struct Film: Codable {
    
    let filmId: Int
    let nameRu: String
    let genres: [Genre]
    let rating: String?
    let posterURLPreview: String
    
    enum CodingKeys: String, CodingKey {
        case filmId
        case nameRu
        case genres
        case rating 
        case posterURLPreview = "posterUrlPreview"
    }
}


