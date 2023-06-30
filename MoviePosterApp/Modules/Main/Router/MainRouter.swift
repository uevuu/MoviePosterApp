//
//  MainRouter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

// MARK: - MainRouter
final class MainRouter {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
}

// MARK: - MainRouterInput
extension MainRouter: MainRouterInput {
    func goToFilmModule(filmId: String) {
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
