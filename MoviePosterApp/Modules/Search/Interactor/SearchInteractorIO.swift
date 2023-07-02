//
//  SearchInteractorIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

// MARK: - SearchInteractorInput
protocol SearchInteractorInput: AnyObject {
    func obtainFilms(by keyWord: String, page: Int)
}

// MARK: - SearchInteractorOutput
protocol SearchInteractorOutput: AnyObject {
    func didFinishObtainFilms(_ films: [FilmByKeyword], pageCount: Int)
}
