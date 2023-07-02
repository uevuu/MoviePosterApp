//
//  FilmCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 27.06.2023.
//

import UIKit

// MARK: - FilmCell
final class FilmCell: UICollectionViewCell {
    static let reuseIdentifier: String = "FilmCellReuseIdentifier"
    
    private lazy var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.addSubview(filmImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        filmImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(imageUrlString: String) {
        let url = URL(string: imageUrlString)
        filmImageView.kf.setImage(with: url)
    }
}
