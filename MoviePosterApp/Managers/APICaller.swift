import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private let baseURl = "https://kinopoiskapiunofficial.tech/"
        
    enum APIError: Error {
        case failedToGetData
    }
    
    
    private func createRequest<T: Decodable>(apiURL: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURl + apiURL) else { return }
        var myRequest = URLRequest(url: url)
        myRequest.httpMethod = "GET"
        myRequest.setValue("e30ffed0-76ab-4dd6-b41f-4c9da2b2735b", forHTTPHeaderField: "X-API-KEY")
        myRequest.setValue("application/json", forHTTPHeaderField: "application/json")
        URLSession.shared.dataTask(with: myRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    // work
    func getFilmsByKeyWord(keyWord: String, page: Int, completion: @escaping (Result<Films, Error>) -> Void) {
        createRequest(apiURL: "api/v2.1/films/search-by-keyword?keyword=\(keyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)", completion: completion)
    }
    // work
    func getDigitalReleases(year: String, month: String, page: Int, completion: @escaping (Result<Releases, Error>) -> Void) {
        createRequest(apiURL: "api/v2.1/films/releases?year=\(year)&month=\(month)&page=\(page)", completion: completion)
    }
    
    // work
    func getPremieres(year: String, month: String, completion: @escaping (Result<Premieres, Error>) -> Void) {
        createRequest(apiURL: "api/v2.2/films/premieres?year=\(year)&month=\(month)", completion: completion)
    }
    
    // work
    func getTopFilms(topType: TypeTop, page: Int, completion: @escaping (Result<Films, Error>) -> Void) {
        createRequest(apiURL: "api/v2.2/films/top?type=\(topType.rawValue)&page=\(page)", completion: completion)
    }
    
//    func getFilmInfo(filmId: Int, completion: @escaping (Result<FilmsByKeyWord, Error>) -> Void) {
//        createRequest(apiURL: "api/v2.2/films/\(filmId)", completion: completion)
//    }
}
