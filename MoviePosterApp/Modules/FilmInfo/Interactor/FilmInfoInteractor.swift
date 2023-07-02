//
//  FilmInfoInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

final class FilmInfoInteractor: FilmInfoInteractorInput {
    weak var output: FilmInfoInteractorOutput?
    private let filmInfoService: FilmInfoService
    private let watchListService: WatchListService
    
    init(
        filmInfoService: FilmInfoService,
        watchListService: WatchListService
    ) {
        self.filmInfoService = filmInfoService
        self.watchListService = watchListService
    }
    
    func obtainFilmInfo(_ filmId: String) {
        filmInfoService.getFilmInfo(filmId: filmId) { [weak self] result in
            switch result {
            case .success(let filmInfo):
                self?.output?.didFinishObtainFilmInfo(filmInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func obtainStaffFromFilm(_ filmId: String) {
        filmInfoService.getStaffFromFilm(filmId: filmId) { [weak self] result in
            switch result {
            case .success(let staff):
                self?.output?.didFinishObtainStaffFromFilm(staff)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func changeFilmStatus(_ filmInfo: FilmInfo?) {
        if let film = filmInfo {
            if watchListService.filmIsAdded(filmId: film.kinopoiskId) {
                watchListService.deleteFilm(filmId: film.kinopoiskId)
                output?.didFinishDeleteFromWatchList()
            } else {
                watchListService.saveFilm(filmInfo: film)
                output?.didFinishAddToWatchList()
            }
        }
    }
    
    func isFilmAddedToWatchList(filmId: Int) {
        let isAdded = watchListService.filmIsAdded(filmId: filmId)
        output?.didFinishCheckFilmStatus(isAdded: isAdded)
    }
}
