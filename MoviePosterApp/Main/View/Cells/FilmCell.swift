//
//  FilmCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 27.06.2023.
//

import UIKit

final class FilmCell: UICollectionViewCell {
    static let reuseIdentifier: String = "FilmCellReuseIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        setConstraints()
    }
    
    private func setConstraints() {
    }
}
