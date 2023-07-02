//
//  WatchListInteractorIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

// MARK: - WatchListInteractorInput
protocol WatchListInteractorInput: AnyObject {
    func obtainFilms()
}

// MARK: - WatchListInteractorOutput
protocol WatchListInteractorOutput: AnyObject {
    func didFinishObtainFilms(_ films: [FilmInfo])
}
