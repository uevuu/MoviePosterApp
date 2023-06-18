//
//  MainModuleBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit

final class MainModuleBuilder {
    static func build() -> UIViewController {
        let router = MainRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(router: router, interactor: interactor)
        let viewController = MainViewController()
        viewController.output = presenter
        presenter.view = viewController
        interactor.output = presenter
        return viewController
    }
}
