//
//  WatchListRouterI.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

// MARK: - WatchListRouterInput
protocol WatchListRouterInput: AnyObject {
    func goToFilmModule(filmId: Int)
}
