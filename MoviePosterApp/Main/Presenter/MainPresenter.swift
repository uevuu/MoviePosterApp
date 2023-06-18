//
//  MainPresenter.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

// MARK: - MainPresenter
final class MainPresenter {
    // MARK: - Dependencies
    weak var view: MainViewInput?
    var router: MainRouterInput
    var interactor: MainInteractorInput
    
    // MARK: - Properties
    private let sections: [Section] = [
        AwaitFilmsSection(),
        FilmsSelection()
    ]
    
    init(
        router: MainRouterInput,
        interactor: MainInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
    func didFinishObtainingFormattedString(_ string: String) {
        view?.showFormattedString(string)
        // что-то с роутером можно делать
        
    }
}

// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {
    func getSections() -> [Section] {
        return sections
    }
    
    func didPressedAction() {
        interactor.obtainFormattedString()
    }
}

// MARK: - MainRouterOutput
extension MainPresenter: MainRouterOutput {
}
