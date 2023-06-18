//
//  AwaitFilmCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 19.06.2023.
//

import UIKit
//import Kingfisher

// MARK: - AwaitFilmCell
final class AwaitFilmCell: UICollectionViewCell {
    static let reuseIdentifier: String = "AwaitFilmCellReuseIdentifier"
    
    private lazy var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "filmImage")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var awaitRatinLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: "89%",
            attributes: [
                .strokeColor: UIColor(named: "LightBlueColor") ?? .black,
                .strokeWidth: -2
            ]
        )
        label.font = UIFont.systemFont(ofSize: 68, weight: .semibold)
        label.textAlignment = .left
        label.textColor = UIColor(named: "AppBackground")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
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
        contentView.addSubview(awaitRatinLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        filmImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
        awaitRatinLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
    func configureCell(title: String, imageUrlString: String? ) {
    }
}
