//
//  MainViewIO.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 12.06.2023.
//

import UIKit

// MARK: - MainViewInput
protocol MainViewInput: AnyObject {
    func reloadSection(at section: Int)
    func swipeTo(indexPath: IndexPath)
    func selectionHeaderScrollTo(_ type: BarSrollTo)
}

// MARK: - MainViewOutput
protocol MainViewOutput: AnyObject {
    func viewDidLoadEvent()
    func getNumberOfItemsInSection(at section: Int) -> Int
    func getReuseIdentifierForItemAt(indexPath: IndexPath) -> String
    func getReuseIdentifierForHeader(indexPath: IndexPath) -> String
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath)
    func swipeSelectionTo(section: Int)
    func startDisplaying(_ indexPath: IndexPath)
    func finishDisplaying(_ indexPath: IndexPath)
    func selectionSwipped()
    func getSections() -> [Section]
}
