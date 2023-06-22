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
}

// MARK: - MainViewOutput
protocol MainViewOutput: AnyObject {
    func viewDidLoadEvent()
    func getNumberOfItemsInSection(at section: Int) -> Int
    func catchCellCreation(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell
    func catchHeaderCreation(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView
    func getSections() -> [Section]
}
