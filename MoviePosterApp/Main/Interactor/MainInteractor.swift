//
//  MainInteractor.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?

    func obtainFormattedString() {
        let numbers = [1, 2, 3, 10, 20]
        let numbersString = numbers.map({"\($0)"}).joined(separator: ",")
        output?.didFinishObtainingFormattedString(numbersString)
    }
}
