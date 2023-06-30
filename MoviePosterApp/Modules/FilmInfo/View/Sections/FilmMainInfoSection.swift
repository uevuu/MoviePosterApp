//
//  FilmMainInfoSection.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit

// MARK: - FilmMainInfoSection
final class FilmMainInfoSection: Section {
    func layoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(200)
            )
        )
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(0),
            top: .fixed(10),
            trailing: .fixed(0),
            bottom: .fixed(0)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(200)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
