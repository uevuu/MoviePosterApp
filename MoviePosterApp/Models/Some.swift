//import Foundation
//
//
//struct TopAwaitFilms: Codable {
//    let films: [AwaitFilm]
//}
//
//struct FilmsByKeyWord: Codable {
//    let keyword: String
//    let pagesCount: Int
//    let films: [FilmForKeyWord]
//    let searchFilmsCountResult: Int
//}
//
//struct FilmForKeyWord: Codable {
//    let filmID: Int
//    let nameRu: String
//    let type: TypeEnum
//    let posterURL, posterURLPreview: String
//
//    enum CodingKeys: String, CodingKey {
//        case filmID = "filmId"
//        case nameRu
//        case posterURL = "posterUrl"
//        case posterURLPreview = "posterUrlPreview"
//    }
//}
//
//struct AwaitFilm: Codable {
//    let filmID: Int
//    let nameRu: String
//    let nameEn: String?
//    let year: String
//    let filmLength: String?
//    let countries: [Country]
//    let genres: [Genre]
//    let rating: String
//    let ratingVoteCount: Int
//    let posterURL, posterURLPreview: String
//
//    enum CodingKeys: String, CodingKey {
//        case filmID = "filmId"
//        case nameRu, nameEn, year, filmLength, countries, genres, rating, ratingVoteCount
//        case posterURL = "posterUrl"
//        case posterURLPreview = "posterUrlPreview"
//    }
//}


enum TypeEnum: String, Codable {
    case film = "FILM"
    case miniSeries = "MINI_SERIES"
    case tvSeries = "TV_SERIES"
    case tvShow = "TV_SHOW"
}

enum TypeTop: String {
    case topAwaitFilms = "TOP_AWAIT_FILMS"
    case topBestfilms = "TOP_250_BEST_FILMS"
    case topPopularFilms = "TOP_100_POPULAR_FILMS"
}

