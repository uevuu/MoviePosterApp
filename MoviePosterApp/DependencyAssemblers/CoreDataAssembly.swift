//
//  CoreDataAssembly.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import Swinject

final class CoreDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WatchListService.self) { _ in
            WatchListService()
        }
        .inObjectScope(.container)
    }
}
