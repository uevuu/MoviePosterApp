//
//  MainPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit

// MARK: - MainPresenter
final class MainPresenter {
    weak var view: MainViewInput?
    private var router: MainRouterInput
    private var interactor: MainInteractorInput
    
    // MARK: - Properties
    
    private var topAwaitFilms = Films(pagesCount: 0, films: [])
    private var premiereFilms = Premieres(total: 0, items: [])
    private var topRatedFilms = Films(pagesCount: 0, films: [])
    private var popularFilms = Films(pagesCount: 0, films: [])
    private let sections: [Section] = [
        AwaitFilmsSection(),
        FilmsSelection()
    ]
    private var startDisplay: Int?
    private var finishDisplay: Int?
    private var currDisplay = 0
    
    init(
        router: MainRouterInput,
        interactor: MainInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
    func didFinishObtainAwaitFilms(_ films: Films) {
        topAwaitFilms = films
        view?.reloadSection(at: 0)
    }
    
    func didFinishObtainPremieres(_ premieres: Premieres) {
        premiereFilms = premieres
        view?.reloadSelection(at: IndexPath(item: 0, section: 1))
    }
    
    func didFinishObtainTopRatedFilms(_ films: Films) {
        topRatedFilms = films
        view?.reloadSelection(at: IndexPath(item: 1, section: 1))
    }
    
    func didFinishObtainPopularFilms(_ films: Films) {
        popularFilms = films
        view?.reloadSelection(at: IndexPath(item: 2, section: 1))
    }
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    func viewDidLoadEvent() {
        interactor.obtainAwaitFilms()
        interactor.obtainPremieres()
        interactor.obtainPopularFilms()
        interactor.obtainTopRatedFilms()
    }
    
    func getNumberOfItemsInSection(at section: Int) -> Int {
        switch section {
        case 0:
            return topAwaitFilms.films.count
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return AwaitFilmCell.reuseIdentifier
        case 1:
            return SelectionFilmCell.reuseIdentifier
        default:
            return "cell"
        }
    }
    
    func getReuseIdentifierForHeader(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return AwaitFilmsSectionHeader.reuseIdentifier
        case 1:
            return FilmsSelectionHeader.reuseIdentifier
        default:
            return "header"
        }
    }
    
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        switch cell {
        case let awaitFilmCell as AwaitFilmCell:
            let film = topAwaitFilms.films[indexPath.item]
            awaitFilmCell.configureCell(
                imageUrlString: film.posterUrlPreview,
                rating: film.rating
            )
        case let selectionsFilmCell as SelectionFilmCell:
            switch indexPath.item {
            case 0:
                selectionsFilmCell.configureCell(
                    imagesUrl: premiereFilms.items.map { $0.posterUrlPreview },
                    selectionFilmOutput: self
                )
            case 1:
                selectionsFilmCell.configureCell(
                    imagesUrl: topRatedFilms.films.map { $0.posterUrlPreview },
                    selectionFilmOutput: self
                )
            case 2:
                selectionsFilmCell.configureCell(
                    imagesUrl: popularFilms.films.map { $0.posterUrlPreview },
                    selectionFilmOutput: self
                )
            default:
                break
            }
        default:
            break
        }
    }

    func getSections() -> [Section] {
        return sections
    }
    
    func swipeSelectionTo(section: Int) {
        view?.swipeTo(indexPath: IndexPath(item: section, section: 1))
    }
    
    func startDisplaying(_ indexPath: IndexPath) {
        if indexPath.section == 1 {
            startDisplay = indexPath.item
        }
    }
    
    func finishDisplaying(_ indexPath: IndexPath) {
        if indexPath.section == 1 {
            finishDisplay = indexPath.item
            if finishDisplay != startDisplay {
                currDisplay = startDisplay ?? 0
                switch startDisplay {
                case 0:
                    view?.selectionHeaderScrollTo(.premieres)
                case 1:
                    view?.selectionHeaderScrollTo(.topRated)
                case 2:
                    view?.selectionHeaderScrollTo(.popular)
                default:
                    break
                }
            }
        }
    }
    
    func selectItemAt(at indexPath: IndexPath) {
        router.goToFilmModule(filmId: "\(topAwaitFilms.films[indexPath.item].filmId)")
    }
}

extension MainPresenter: SelectionFilmOutput {
    func showFilmInfoAt(at indexPath: IndexPath) {
        switch currDisplay {
        case 0:
            router.goToFilmModule(filmId: "\(premiereFilms.items[indexPath.item].kinopoiskId)")
        case 1:
            router.goToFilmModule(filmId: "\(topRatedFilms.films[indexPath.item].filmId)")

        case 2:
            router.goToFilmModule(filmId: "\(popularFilms.films[indexPath.item].filmId)")
        default:
            break
        }
    }
}
