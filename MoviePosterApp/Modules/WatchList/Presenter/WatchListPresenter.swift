//
//  WatchListPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit

// MARK: - WatchListPresenter
final class WatchListPresenter {
    weak var view: WatchListViewInput?
    private var router: WatchListRouterInput
    private var interactor: WatchListInteractorInput
    private var markedFilms: [FilmInfo] = []
    
    init(
        router: WatchListRouterInput,
        interactor: WatchListInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - WatchListInteractorOutput
extension WatchListPresenter: WatchListInteractorOutput {
    func didFinishObtainFilms(_ films: [FilmInfo]) {
        if films != markedFilms {
            markedFilms = films
            view?.reloadView()
        }
    }
}

// MARK: - WatchListViewOutput
extension WatchListPresenter: WatchListViewOutput {
    func viewDidLoadEvent() {
        interactor.obtainFilms()
    }
    
    func viewWillAppearEvent() {
        interactor.obtainFilms()
    }
    
    func getFilmsCount() -> Int {
        return markedFilms.count
    }
    
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return FilmTableViewCell.reuseIdentifier
        default:
            return "cell"
        }
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        switch cell {
        case let filmCell as FilmTableViewCell:
            let filmInfo = markedFilms[indexPath.item]
            let dataForCell = FilmDataForCell(
                title: filmInfo.nameRu ?? "Без названия",
                posterUrlPreview: filmInfo.posterUrlPreview,
                // swiftlint:disable force_unwrapping
                year: filmInfo.year != nil ? String(filmInfo.year!) : "----",
                rating: filmInfo.ratingImdb != nil ? String(filmInfo.ratingImdb!) : "--",
                filmLength: filmInfo.filmLength != nil ? "\(filmInfo.filmLength!) Минут" : "? Минут",
                // swiftlint:enable force_unwrapping
                isTicketsAvailable: filmInfo.isTicketsAvailable
            )
            filmCell.configureCell(dataForCell: dataForCell)
        default:
            break
        }
    }
    
    func selectFilm(at indexPath: IndexPath) {
        router.goToFilmModule(filmId: markedFilms[indexPath.item].kinopoiskId)
    }
}
