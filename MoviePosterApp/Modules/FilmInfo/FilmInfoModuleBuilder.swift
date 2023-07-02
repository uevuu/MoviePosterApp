//
//  FilmInfoModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit
import Swinject

// MARK: - FilmInfoModuleBuilder
final class FilmInfoModuleBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build(
        filmId: String,
        navigationController: UINavigationController?
    ) -> UIViewController {
        let viewController = FilmInfoViewController()
        let router = FilmInfoRouter(navigationController: navigationController)
        let interactor = FilmInfoInteractor(
            filmInfoService: resolver.resolve(),
            watchListService: resolver.resolve()
        )
        let presenter = FilmInfoPresenter(
            filmId: filmId,
            router: router,
            interactor: interactor
        )
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return viewController
    }
}
