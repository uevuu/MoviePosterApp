//
//  SearchInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

// MARK: - SearchInteractor
final class SearchInteractor {
    weak var output: SearchInteractorOutput?
    private let filmSearchService: FilmSearchService
    private let filmInfoLocalDataSource: FilmInfoLocalDataSource
    
    init(
        filmSearchService: FilmSearchService,
        filmInfoLocalDataSource: FilmInfoLocalDataSource
    ) {
        self.filmSearchService = filmSearchService
        self.filmInfoLocalDataSource = filmInfoLocalDataSource
    }
}

// MARK: - SearchInteractorInput
extension SearchInteractor: SearchInteractorInput {
    func obtainFilms(by keyWords: String, page: Int) {
        filmSearchService.getFilmsByKeyword(
            keyWords,
            page: page
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.didFinishObtainFilms(
                    response.films,
                    pageCount: response.pagesCount
                )
            case .failure(let error):
                print(error)
            }
        }
    }
}
