//
//  FilmInfoInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

final class FilmInfoInteractor: FilmInfoInteractorInput {
    weak var output: FilmInfoInteractorOutput?
    private let filmInfoService: FilmInfoService
    
    init(filmInfoService: FilmInfoService) {
        self.filmInfoService = filmInfoService
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
}
