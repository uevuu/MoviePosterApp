//
//  MainRouter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

final class MainRouter {
    weak var presenter: MainPresenterInput?
}

extension MainRouter: MainRouterInput {
}

extension MainRouter: MainRouterOutput {
}
