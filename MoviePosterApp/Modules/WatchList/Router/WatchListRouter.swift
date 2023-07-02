//
//  WatchListRouter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit
import Swinject

// MARK: - WatchListRouter
final class WatchListRouter {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController?
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
}

// MARK: - WatchListRouterInput
extension WatchListRouter: WatchListRouterInput {
    func goToFilmModule(filmId: Int) {
        let filmInfoBuilder = FilmInfoModuleBuilder(resolver: resolver)
        let filmInfoViewController = filmInfoBuilder.build(
            filmId: filmId,
            navigationController: navigationController
        )
        navigationController?.pushViewController(
            filmInfoViewController,
            animated: true
        )
    }
}
