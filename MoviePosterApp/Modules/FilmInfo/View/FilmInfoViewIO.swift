//
//  FilmInfoViewIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit

// MARK: - FilmInfoViewInput
protocol FilmInfoViewInput: AnyObject {
    func reloadSection(_ section: Int)
}

// MARK: - FilmInfoViewOutput
protocol FilmInfoViewOutput: AnyObject {
    func viewDidLoadEvent()
    func getSections() -> [Section]
    func getSectionCount() -> Int
    func getNumberOfItemsInSection(at section: Int) -> Int
    func getReuseIdentifierForHeader(indexPath: IndexPath) -> String
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath)
    func backButtonTapped()
    func bookmarkButtonTapped()
}
