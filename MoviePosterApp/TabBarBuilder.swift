//
//  TabBarBuilder.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import UIKit

final class TabBarBuilder {
    func build() -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = .blue
        tabBar.tabBar.tintColor = UIColor(named: "LightBlueColor")
        let mainViewController = MainModuleBuilder.build()
        let favouriteViewController = UIViewController()
        favouriteViewController.view.backgroundColor = .blue
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteViewController)
        tabBar.addViewController(
            viewController: mainNavigationController,
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
