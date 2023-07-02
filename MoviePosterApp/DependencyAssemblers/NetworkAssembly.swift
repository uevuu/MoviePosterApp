//
//  NetworkAssembly.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 21.04.2023.
//

import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieNetworkService.self) { _ in
            MovieNetworkService()
        }
        .inObjectScope(.container)
        
        container.register(FilmInfoService.self) { _ in
            FilmInfoService()
        }
        .inObjectScope(.container)
        
        container.register(FilmSearchService.self) { _ in
            FilmSearchService()
        }
        .inObjectScope(.container)
    }
}
