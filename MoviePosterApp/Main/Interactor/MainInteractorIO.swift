//
//  MainInteractorIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

// MARK: - MainInteractorInput
protocol MainInteractorInput: AnyObject {
    func obtainFormattedString()
}

// MARK: - MainInteractorOutput
protocol MainInteractorOutput: AnyObject {
    func didFinishObtainingFormattedString(_ string: String)
}
