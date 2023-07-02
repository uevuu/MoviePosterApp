//
//  LocalDataSource.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import Swinject

final class LocalDataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FilmInfoLocalDataSource.self) { _ in
            FilmInfoLocalDataSource()
        }
        .inObjectScope(.container)
    }
}
