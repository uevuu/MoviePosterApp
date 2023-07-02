//
//  FilmInfoInteractorIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

// MARK: - FilmInfoInteractorInput
protocol FilmInfoInteractorInput: AnyObject {
    func obtainFilmInfo(_ filmId: String)
    func obtainStaffFromFilm(_ filmId: String)
    func changeFilmStatus(_ filmInfo: FilmInfo?)
    func isFilmAddedToWatchList(filmId: Int)
}

// MARK: - FilmInfoInteractorOutput
protocol FilmInfoInteractorOutput: AnyObject {
    func didFinishObtainFilmInfo(_ filmInfo: FilmInfo)
    func didFinishObtainStaffFromFilm(_ staff: [Staff])
    func didFinishAddToWatchList()
    func didFinishDeleteFromWatchList()
    func didFinishCheckFilmStatus(isAdded: Bool)
}