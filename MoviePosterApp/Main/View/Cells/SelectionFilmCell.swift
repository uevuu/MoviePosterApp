//
//  SelectionFilmCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit
//import Kingfisher

// MARK: - SelectionFilmCell
final class SelectionFilmCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SelectionFilmCellReuseIdentifier"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .red
        setConstraints()
    }
    
    private func setConstraints() {
    }
    
    func configureCell(title: String, imageUrlString: String? ) {
    }
}
