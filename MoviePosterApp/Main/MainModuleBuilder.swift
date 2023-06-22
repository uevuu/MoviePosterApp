//
//  MainModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

final class MainModuleBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build() -> UIViewController {
        let router = MainRouter()
        let interactor = MainInteractor(moviewNetworkService: resolver.resolve())
        let presenter = MainPresenter(router: router, interactor: interactor)
        let viewController = MainViewController()
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return viewController
    }
}
