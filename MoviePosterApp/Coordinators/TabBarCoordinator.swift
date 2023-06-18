//
//  TabBarCoordinator.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

// MARK: - TabBarCoordinator
final class TabBarCoordinator: FlowCoordinatorProtocol {
    private let window: UIWindow
    private let resolver: Resolver
    private let tabBar = UITabBarController()
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(
        window: UIWindow,
        resolver: Resolver,
        finishHandler: @escaping (() -> Void)
    ) {
        self.window = window
        self.resolver = resolver
        self.finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        window.rootViewController = tabBar
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
