//
//  MainRouterI.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

// MARK: - MainRouterInput
protocol MainRouterInput: AnyObject {
    func goToFilmModule(filmId: Int)
    func goToSearchModule()
}
