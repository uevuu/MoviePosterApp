//
//  WatchListModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit
import Swinject

// MARK: - WatchListModuleBuilder
final class WatchListModuleBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build() -> UIViewController {
        let viewController = WatchListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let router = WatchListRouter(
            resolver: resolver,
            navigationController: navigationController
        )
        let interactor = WatchListInteractor(watchListService: resolver.resolve())
        let presenter = WatchListPresenter(
            router: router,
            interactor: interactor
        )
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return navigationController
    }
}
