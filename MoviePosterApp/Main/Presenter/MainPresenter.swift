//
//  MainPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit

// MARK: - MainPresenter
final class MainPresenter {
    
    // MARK: - Dependencies
    
    weak var view: MainViewInput?
    private var router: MainRouterInput
    private var interactor: MainInteractorInput
    
    // MARK: - Properties
    
    private var topAwaitFilms = Films(pagesCount: 0, films: [])
    private let sections: [Section] = [
        AwaitFilmsSection(),
        FilmsSelection()
    ]
    private var startDisplay: Int?
    private var finishDisplay: Int?
    private var tappedInSectionHeader = false
    
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
    
    func didFinishObtainTopRatedFilms(_ films: Films) {
        print("didFinishObtainTopRatedFilms")
    }
    
    func didFinishObtainPremieres(_ premieres: Premieres) {
        print("didFinishObtainPremieres")
    }
    
    func didFinishObtainPopularFilms(_ films: Films) {
        print("didFinishObtainPopularFilms")
    }
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    func viewDidLoadEvent() {
        interactor.obtainAwaitFilms()
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
        default:
            break
        }
    }

    func getSections() -> [Section] {
        return sections
    }
    
    func swipeSelectionTo(section: Int) {
        print("swipeSelectionTo")
        tappedInSectionHeader = true
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
            if finishDisplay != startDisplay  && !tappedInSectionHeader {
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
    func selectionSwipped() {
        print("selectionSwipped")
        tappedInSectionHeader = false
    }
}

// MARK: - MainRouterOutput
extension MainPresenter: MainRouterOutput {
}
