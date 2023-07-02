//
//  SearchModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import UIKit
import Swinject

// MARK: - SearchModuleBuilder
final class SearchModuleBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build(
        navigationController: UINavigationController?
    ) -> UIViewController {
        let viewController = SearchViewController()
        let router = SearchRouter(
            resolver: resolver,
            navigationController: navigationController
        )
        let interactor = SearchInteractor(
            filmSearchService: resolver.resolve(),
            filmInfoLocalDataSource: resolver.resolve()
        )
        let presenter = SearchPresenter(
            router: router,
            interactor: interactor
        )
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return viewController
    }
}
