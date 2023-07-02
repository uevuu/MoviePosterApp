//
//  WatchListViewIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit

// MARK: - WatchListViewInput
protocol WatchListViewInput: AnyObject {
    func reloadView()
}

// MARK: - WatchListViewOutput
protocol WatchListViewOutput: AnyObject {
    func viewDidLoadEvent()
    func viewWillAppearEvent()
    func getFilmsCount() -> Int
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath)
    func selectFilm(at indexPath: IndexPath)
}
