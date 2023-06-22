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
    var router: MainRouterInput
    var interactor: MainInteractorInput
    
    // MARK: - Properties
    private var topAwaitFilms = Films(pagesCount: 0, films: [])
    private let sections: [Section] = [
        AwaitFilmsSection(),
        FilmsSelection()
    ]
    
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
    
    func catchCellCreation(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AwaitFilmCell.reuseIdentifier,
                for: indexPath
            ) as? AwaitFilmCell else {
                fatalError("Error with getting AwaitFilmCell")
            }
            let film = topAwaitFilms.films[indexPath.item]
            cell.configureCell(
                imageUrlString: film
                    .posterUrlPreview,
                rating: film.rating
            )
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SelectionFilmCell.reuseIdentifier,
                for: indexPath
            ) as? SelectionFilmCell else {
                fatalError("Error with getting SelectionFilmCell")
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
        
    func catchHeaderCreation(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AwaitFilmsSectionHeader.reuseIdentifier,
                for: indexPath
            ) as? AwaitFilmsSectionHeader else {
                fatalError("Error with getting AwaitFilmsSectionHeader")
            }
            return header
        case 1:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FilmsSelectionHeader.reuseIdentifier,
                for: indexPath
            ) as? FilmsSelectionHeader else {
                fatalError("Error with getting FilmsSelectionHeader")
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func getSections() -> [Section] {
        return sections
    }
}

// MARK: - MainRouterOutput
extension MainPresenter: MainRouterOutput {
}
