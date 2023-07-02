//
//  SearchRouterI.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

// MARK: - SearchRouterInput
protocol SearchRouterInput: AnyObject {
    func goToPreviousModule()
    func goToFilmModule(filmId: Int)
}
