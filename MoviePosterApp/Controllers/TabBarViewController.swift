import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    private func setUp() {
        let mainVC = MainViewController()
        let searchVC = SearchViewController()
        let favVC = FavouriteViewController()
        
        mainVC.title = "Главная"
        searchVC.title = "Поиск"
        favVC.title = "Изранное"
        
//        mainVC.navigationItem.largeTitleDisplayMode = .always
//        searchVC.navigationItem.largeTitleDisplayMode = .always
//        favVC.navigationItem.largeTitleDisplayMode = .always
        
        let mainNav = UINavigationController(rootViewController: mainVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favNav = UINavigationController(rootViewController: favVC)
        
        mainNav.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        searchNav.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
        favNav.tabBarItem = UITabBarItem(title: "Изранное", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        mainNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        favNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([mainNav, searchNav, favNav], animated: false)
    }
    
}
