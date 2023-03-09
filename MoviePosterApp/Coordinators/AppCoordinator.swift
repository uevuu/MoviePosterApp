import UIKit

class AppCoordinator {
    
    weak var window: UIWindow?
    weak var tabBarController: UITabBarController?
    static let shared: AppCoordinator = .init()
    
    func start() {
        let tabBarController = UITabBarController()
        self.tabBarController = tabBarController
//        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [
            main(),
            search(),
            favourite()
        ]
        window?.rootViewController = tabBarController        
    }
    
    private func main() -> UIViewController {
        let vc = MainViewController()
        vc.tabBarItem = .init(title: "Главная", image: .init(systemName: "house"), selectedImage: .init(systemName: "house"))
        return vc
    }
    
    private func search() -> UIViewController {
        return SearchCoordinator.shared.start()
    }
    
    private func favourite() -> UIViewController {
        let vc = ViewController()
        vc.tabBarItem = .init(title: "Избранное", image: .init(systemName: "star"), selectedImage: .init(systemName: "star"))
        return vc

    }
    
}

