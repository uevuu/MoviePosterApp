//
//  MainViewIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

// MARK: - MainViewInput
protocol MainViewInput: AnyObject {
    func showFormattedString(_ string: String)
}

// MARK: - MainViewOutput
protocol MainViewOutput: AnyObject {
    func didPressedAction()
    func getSections() -> [Section]
}
