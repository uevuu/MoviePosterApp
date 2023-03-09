import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        APICaller.shared.getTopFilms(topType: .TopBestfilms, page: 1) { result in
//            switch result {
//            case .success(let models):
//                print(models)
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
        
//        APICaller.shared.getFilmsByKeyWord(keyWord: "кар", page: 1) { result in
//            switch result {
//            case .success(let models):
//                print(models)
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
        
//        APICaller.shared.getDigitalReleases(year: "2023", month: "march", page: 2) { result in
//            switch result {
//            case .success(let models):
//                print(models)
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
        
        APICaller.shared.getPremieres(year: "2023", month: "march") { result in
            switch result {
            case .success(let models):
                print(models)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }


}

