import UIKit

class SearchViewController: UIViewController {

    private let searchController: UISearchController = {
        let results = UIViewController()
        results.view.backgroundColor = .white
        let vc = UISearchController(searchResultsController: results)
        vc.searchBar.placeholder = "Фильмы, Сериалы"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Поиск"
        navigationItem.searchController = searchController

        
    }


}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        print(query)
    }
    
    
}

