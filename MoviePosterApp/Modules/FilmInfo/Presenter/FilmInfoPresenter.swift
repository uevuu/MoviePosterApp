//
//  FilmInfoPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit

// MARK: - FilmInfoPresenter
final class FilmInfoPresenter {
    private let selectedFilmId: Int
    private var selectedFilmInfo: FilmInfo?
    private var filmStaff: [Staff]?
    weak var view: FilmInfoViewInput?
    private let sections: [Section] = [
        FilmMainInfoSection(),
        StaffInfoSection()
    ]
    private var router: FilmInfoRouterInput
    private var interactor: FilmInfoInteractorInput
    
    init(
        filmId: Int,
        router: FilmInfoRouterInput,
        interactor: FilmInfoInteractorInput
    ) {
        self.selectedFilmId = filmId
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - FilmInfoInteractorOutput
extension FilmInfoPresenter: FilmInfoInteractorOutput {
    func didFinishObtainFilmInfo(_ filmInfo: FilmInfo) {
        selectedFilmInfo = filmInfo
        view?.reloadSection(0)
    }
    
    func didFinishObtainStaffFromFilm(_ staff: [Staff]) {
        filmStaff = staff
        view?.reloadSection(1)
    }
    
    func didFinishAddToWatchList() {
        view?.makeBookmarkFill()
    }
    
    func didFinishDeleteFromWatchList() {
        view?.makeBookmarkUnfill()
    }
    
    func didFinishCheckFilmStatus(isAdded: Bool) {
        if isAdded {
            view?.makeBookmarkFill()
        }
    }
}

// MARK: - FilmInfoViewOutput
extension FilmInfoPresenter: FilmInfoViewOutput {    
    func viewDidLoadEvent() {
        interactor.obtainFilmInfo(selectedFilmId)
        interactor.obtainStaffFromFilm(selectedFilmId)
    }
    
    func viewWillAppearEvent() {        
        interactor.isFilmAddedToWatchList(filmId: selectedFilmId)
    }
    
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return FilmMainInfoCell.reuseIdentifier
        case 1:
            return StaffInfoCell.reuseIdentifier
        default:
            return "cell"
        }
    }
    
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        switch cell {
        case let infoCell as FilmMainInfoCell:
            if let info = selectedFilmInfo {
                infoCell.configureCell(filmInfo: info)
            }
        case let staffCell as StaffInfoCell:
            if let person = filmStaff?[indexPath.item] {
                var personName = "Отсутствует"
                if let name = person.nameRu, !name.isEmpty {
                    personName = name
                } else if let name = person.nameEn, !name.isEmpty {
                    personName = name
                }
                staffCell.configureCell(
                    imageUrlString: person.posterUrl,
                    name: personName
                )
            }
        default:
            break
        }
    }
    
    func getSections() -> [Section] {
        return sections
    }
    
    func getSectionCount() -> Int {
        return sections.count
    }
    
    func getNumberOfItemsInSection(at section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return filmStaff?.count ?? 0
        default:
            return 0
        }
    }
    
    func getReuseIdentifierForHeader(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 1:
            return StaffInfoHeader.reuseIdentifier
        default:
            return "header"
        }
    }
    
    func backButtonTapped() {
        router.goToPreviousModule()
    }
    
    func bookmarkButtonTapped() {
        interactor.changeFilmStatus(selectedFilmInfo)
    }
}
