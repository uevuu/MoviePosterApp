//
//  MainInteractorIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

// MARK: - MainInteractorInput
protocol MainInteractorInput: AnyObject {
    func obtainAwaitFilms()
    func obtainTopRatedFilms()
    func obtainPremieres()
    func obtainPopularFilms()
}

// MARK: - MainInteractorOutput
protocol MainInteractorOutput: AnyObject {
    func didFinishObtainAwaitFilms(_ films: Films)
    func didFinishObtainTopRatedFilms(_ films: Films)
    func didFinishObtainPremieres(_ premieres: Premieres)
    func didFinishObtainPopularFilms(_ films: Films)
}
