//
//  TabBarBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import UIKit
import Swinject

final class TabBarBuilder {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func build() -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = UIColor(named: "AppBackground")
        tabBar.tabBar.tintColor = UIColor(named: "LightBlueColor")
        
        let mainBuilder = MainModuleBuilder(resolver: resolver)
        let mainViewController = mainBuilder.build()
        let favouriteViewController = UIViewController()
        favouriteViewController.view.backgroundColor = .blue
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteViewController)
        tabBar.addViewController(
            viewController: mainViewController,
            title: "Home",
            image: UIImage(systemName: "house")
        )
        tabBar.addViewController(
            viewController: favouriteNavigationController,
            title: "Watch list",
            image: UIImage(systemName: "bookmark")
        )
        return tabBar
    }
}

extension UITabBarController {
    func addViewController(
        viewController: UIViewController,
        title: String,
        image: UIImage?
    ) {
        viewController.title = title
        viewController.tabBarItem.image = image
        var viewControllers = self.viewControllers ?? []
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}
