//
//  MainInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?
    private let moviewNetworkService: MovieNetworkService
    
    init(moviewNetworkService: MovieNetworkService) {
        self.moviewNetworkService = moviewNetworkService
    }
    
    func obtainAwaitFilms() {
        moviewNetworkService.getTopFilms(topType: .await, page: 1) { [weak self] result in
            switch result {
            case .success(let films):
                self?.output?.didFinishObtainAwaitFilms(films)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func obtainTopRatedFilms() {
        moviewNetworkService.getTopFilms(topType: .best, page: 1) { [weak self] result in
            switch result {
            case .success(let films):
                self?.output?.didFinishObtainTopRatedFilms(films)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func obtainPremieres() {
        moviewNetworkService.getPremieres { [weak self] result in
            switch result {
            case .success(let premieres):
                self?.output?.didFinishObtainPremieres(premieres)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func obtainPopularFilms() {
        moviewNetworkService.getTopFilms(topType: .popular, page: 1) { [weak self] result in
            switch result {
            case .success(let films):
                self?.output?.didFinishObtainPopularFilms(films)
            case .failure(let error):
                print(error)
            }
        }
    }
}
