//
//  MainModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

// MARK: - MainModuleBuilder
final class MainModuleBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build() -> UIViewController {
        let viewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let router = MainRouter(
            resolver: resolver,
            navigationController: navigationController
        )
        let interactor = MainInteractor(moviewNetworkService: resolver.resolve())
        let presenter = MainPresenter(
            router: router,
            interactor: interactor
        )
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return navigationController
    }
}
