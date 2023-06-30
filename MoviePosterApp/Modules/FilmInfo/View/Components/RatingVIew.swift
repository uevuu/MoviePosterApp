//
//  RatingVIew.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit

// MARK: - RatingView
final class RatingView: UIView {
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(named: "OrangeColor")
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = UIColor(named: "OrangeColor")
        imageView.isHidden = true
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
        addSubview(ratingLabel)
        addSubview(starImageView)
        backgroundColor = UIColor(named: "AppBackground")
        clipsToBounds = true
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        starImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().inset(5)
        }
    }
    
    func setRating(_ rating: String) {
        ratingLabel.text = rating
        ratingLabel.isHidden = false
        starImageView.isHidden = false
    }
}
