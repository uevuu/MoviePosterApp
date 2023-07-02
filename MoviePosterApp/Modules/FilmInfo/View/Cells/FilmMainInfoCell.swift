//
//  FilmMainInfoCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit
import Kingfisher

// MARK: - FilmMainInfoCell
final class FilmMainInfoCell: UICollectionViewCell {
    static let reuseIdentifier: String = "FilmMainInfoCellReuseIdentifier"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingView = RatingView()
    
    private lazy var yearInfoLabel = SecondaryInfoView(.year)
    private lazy var firstSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondaryInfoColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var timeInfoLabel = SecondaryInfoView(.length)
    private lazy var secondSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SecondaryInfoColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var statusInfoLabel = SecondaryInfoView(.tickectStatus)

    private lazy var infoStackVIew: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            yearInfoLabel,
            firstSeparator,
            timeInfoLabel,
            secondSeparator,
            statusInfoLabel
        ])
        stackView.spacing = 10
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(mainImageView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(infoStackVIew)
        contentView.addSubview(descriptionLabel)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        setConstraints()
    }
    
    private func setConstraints() {
        let cellWidth = contentView.bounds.width
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(cellWidth * 0.6)
        }
        ratingView.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).inset(10)
            make.trailing.equalTo(mainImageView.snp.trailing).inset(10)
        }
        posterImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mainImageView.snp.bottom)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(95 * cellWidth / 375)
            make.height.equalTo(125 * cellWidth / 375)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(15)
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(25)
        }
        firstSeparator.snp.makeConstraints { make in
            make.width.equalTo(2)
        }
        secondSeparator.snp.makeConstraints { make in
            make.width.equalTo(2)
        }
        infoStackVIew.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20).priority(.medium)
            make.top.equalTo(titleLabel.snp.bottom).offset(20).priority(.high)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(infoStackVIew.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configureCell(filmInfo: FilmInfo) {
        infoStackVIew.isHidden = false
        if let mainImageUrlString = filmInfo.coverUrl {
            mainImageView.kf.setImage(with: URL(string: mainImageUrlString))
        } else {
            mainImageView.image = UIImage(named: "ImageNotAvailable")
        }
        posterImageView.kf.setImage(with: URL(string: filmInfo.posterUrlPreview))
        titleLabel.text = filmInfo.nameRu ?? "Без названия"
        if let rating = filmInfo.ratingImdb {
            ratingView.setRating("\(rating)")
        } else {
            ratingView.setRating("--")
        }
        descriptionLabel.text = filmInfo.description ?? "Описание фильма отсутствуют"
        if let year = filmInfo.year {
            yearInfoLabel.setData("\(year)")
        }
        if let filmLength = filmInfo.filmLength {
            timeInfoLabel.setData("\(filmLength) Минут")
        }
        
        if filmInfo.isTicketsAvailable {
            statusInfoLabel.setData("Доступны")
        } else {
            statusInfoLabel.setData("Недоступны")
        }
    }
}
