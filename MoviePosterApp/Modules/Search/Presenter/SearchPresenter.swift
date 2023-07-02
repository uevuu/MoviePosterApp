//
//  SearchPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import UIKit

// MARK: - SearchPresenter
final class SearchPresenter {
    private var loadedFilms: [FilmByKeyword] = []
    private var lastLoadedPage = 1
    private var isMaxPage = false
    private var keywords = ""
    weak var view: SearchViewInput?
    private var router: SearchRouterInput
    private var interactor: SearchInteractorInput
    
    init(
        router: SearchRouterInput,
        interactor: SearchInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SearchInteractorOutput
extension SearchPresenter: SearchInteractorOutput {
    func didFinishObtainFilms(
        _ films: [FilmByKeyword],
        pageCount: Int
    ) {
        if lastLoadedPage == 1 {
            loadedFilms.removeAll()
        }
        if films.isEmpty {
            isMaxPage = true
        } else {
            loadedFilms.append(contentsOf: films)
            view?.reloadView()
        }
    }
}

// MARK: - SearchViewOutput
extension SearchPresenter: SearchViewOutput {
    func viewDidLoadEvent() {
    }
    
    func getFilmsCount() -> Int {
        return loadedFilms.count
    }
    
    func selectFilm(at indexPath: IndexPath) {
        router.goToFilmModule(filmId: loadedFilms[indexPath.item].filmId)
    }
    
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String {
        return FilmTableViewCell.reuseIdentifier
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        switch cell {
        case let filmCell as FilmTableViewCell:
            if indexPath.item == loadedFilms.count - 1 && !isMaxPage {
                print(lastLoadedPage)
                lastLoadedPage += 1
                interactor.obtainFilms(by: keywords, page: lastLoadedPage)
            }
            let info = loadedFilms[indexPath.item]
            let dataForCell = FilmDataForCell(
                title: info.nameRu ?? "Без названия",
                posterUrlPreview: info.posterUrlPreview,
                // swiftlint:disable force_unwrapping
                year: info.year != nil ? info.year! : "----",
                rating: info.rating != nil ? info.rating! : "--",
                filmLength: info.filmLength != nil ? info.filmLength! : "? Минут",
                // swiftlint:enable force_unwrapping
                isTicketsAvailable: nil
            )
            filmCell.configureCell(dataForCell: dataForCell)
            
        default:
            break
        }
    }
    
    func backButtonTapped() {
        router.goToPreviousModule()
    }
    
    func handleTextInput(_ inputText: String) {
        if !inputText.isEmpty {
            isMaxPage = false
            lastLoadedPage = 1
            keywords = inputText
            interactor.obtainFilms(
                by: keywords,
                page: lastLoadedPage
            )
        }
    }
}
