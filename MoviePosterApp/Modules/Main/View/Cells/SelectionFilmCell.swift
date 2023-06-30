//
//  SelectionFilmCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit
import Kingfisher

// MARK: - SelectionFilmOutput
protocol SelectionFilmOutput: AnyObject {
    func showFilmInfoAt(at indexPath: IndexPath)
}

// MARK: - SelectionFilmCell
final class SelectionFilmCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SelectionFilmCellReuseIdentifier"
    
    private var images: [String] = []
    private weak var output: SelectionFilmOutput?
    
    lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "AppBackground")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            FilmCell.self,
            forCellWithReuseIdentifier: FilmCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let section = FilmInSelectionSection()
            return section.layoutSection()
        }
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(collectionView)
        setConstraints()
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(imagesUrl: [String], selectionFilmOutput: SelectionFilmOutput) {
        if imagesUrl != images {
            images = imagesUrl
            output = selectionFilmOutput
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SelectionFilmCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilmCell.reuseIdentifier,
            for: indexPath
        ) as? FilmCell else {
            fatalError("Error with getting FilmCell")
        }
        let image = images[indexPath.item]
        cell.configureCell(imageUrlString: image)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SelectionFilmCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        output?.showFilmInfoAt(at: indexPath)
    }
}
