//
//  FilmInfoRouter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit

// MARK: - FilmInfoRouter
final class FilmInfoRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - FilmInfoRouterInput
extension FilmInfoRouter: FilmInfoRouterInput {
    func goToPreviousModule() {
        navigationController?.popViewController(animated: true)
    }
}
