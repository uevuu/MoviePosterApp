//
//  RootCoordinator.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

// MARK: - RootCoordinator
final class RootCoordinator: FlowCoordinatorProtocol {
    private let window: UIWindow
    private let resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    private func showLoginFlow() {
        // in future
    }
    
    private func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(
            window: window,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: TabBarCoordinator.self)
        }
        tabBarCoordinator.start(animated: false)
        childCoordinators.append(tabBarCoordinator)
    }
    
    func start(animated: Bool) {
        window.makeKeyAndVisible()
        showMainFlow()
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
