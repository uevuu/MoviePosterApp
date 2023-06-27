//
//  AwaitFilmsSection.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit

// MARK: - AwaitFilmsSection
final class AwaitFilmsSection: Section {
    func layoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.45),
                heightDimension: .fractionalWidth(0.639)
            ),
            subitems: [item]
            )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(44)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        return section
    }
}
