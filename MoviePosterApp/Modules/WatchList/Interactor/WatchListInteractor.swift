//
//  WatchListInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

// MARK: - WatchListInteractor
final class WatchListInteractor {
    weak var output: WatchListInteractorOutput?
    private let watchListService: WatchListService
    
    init(watchListService: WatchListService) {
        self.watchListService = watchListService
    }
}

// MARK: - WatchListInteractorInput
extension WatchListInteractor: WatchListInteractorInput {
    func obtainFilms() {
        let films = watchListService.getFilms()
        output?.didFinishObtainFilms(films)
    }
}
