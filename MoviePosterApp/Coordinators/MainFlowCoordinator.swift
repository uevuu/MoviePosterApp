//
//  MainFlowCoordinator.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import Swinject

// MARK: - MainFlowCoordinator
final class MainFlowCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var parentTabBarController: UITabBarController?
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(
        resolver: Resolver,
        tabBarController: UITabBarController,
        finishHandler: @escaping (() -> Void)
    ) {
        self.resolver = resolver
        self.parentTabBarController = tabBarController
        self.finishHandlers.append(finishHandler)
    }
    
    func start(animated: Bool) {
        showMain()
    }
    
    func showMain() {
        
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}
