//
//  SearchRouter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import UIKit
import Swinject

// MARK: - SearchRouter
final class SearchRouter {
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

// MARK: - SearchRouterInput
extension SearchRouter: SearchRouterInput {
    func goToPreviousModule() {
        navigationController?.popViewController(animated: false)
    }
    
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
