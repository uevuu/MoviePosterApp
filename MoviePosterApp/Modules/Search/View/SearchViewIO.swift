//
//  SearchViewIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import UIKit

// MARK: - SearchViewInput
protocol SearchViewInput: AnyObject {
    func reloadView()
}

// MARK: - SearchViewOutput
protocol SearchViewOutput: AnyObject {
    func viewDidLoadEvent()
    func getFilmsCount() -> Int
    func selectFilm(at indexPath: IndexPath)
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath)
    func handleTextInput(_ text: String)
    func backButtonTapped()
}
