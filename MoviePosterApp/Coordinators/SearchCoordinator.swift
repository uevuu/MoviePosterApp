import UIKit

class SearchCoordinator {
    
    var navigationController: UINavigationController?
    static let shared: SearchCoordinator = .init()

    
    func start() -> UIViewController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = .init(title: "Поиск", image: .init(systemName: "magnifyingglass"), selectedImage: .init(systemName: "magnifyingglass"))
        navigationController = UINavigationController(rootViewController: searchVC)
        return navigationController!
    }
}

