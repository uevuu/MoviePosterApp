import UIKit

class MainPresenter {
    
//    var catalogService: CatalogService = MockCatalogService.shared
    weak var view: ViewController?
    var apiManager = APICaller.shared
    
    func loadCatalog() {
    }
}
