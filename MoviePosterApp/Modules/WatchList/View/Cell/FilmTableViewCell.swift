//
//  FilmTableViewCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit

// MARK: - FilmTableViewCell
final class FilmTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "FilmTableViewCellReuseIdentifier"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingInfoLabel = SecondaryInfoView(.rating)
    private lazy var statusInfoLabel = SecondaryInfoView(.tickectStatus)
    private lazy var yearInfoLabel = SecondaryInfoView(.year)
    private lazy var lengthInfoLabel = SecondaryInfoView(.length)
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            ratingInfoLabel,
            statusInfoLabel,
            yearInfoLabel,
            lengthInfoLabel
        ])
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor(named: "AppBackground")
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.4).priority(.high)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.4 * 0.79)
            make.bottom.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.top.equalTo(posterImageView.snp.top).offset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(15)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(10)
        }
    }
    
    func configureCell(filmInfo: FilmInfo) {
        posterImageView.kf.setImage(with: URL(string: filmInfo.posterUrlPreview))
        titleLabel.text = filmInfo.nameRu ?? "Без названия"
        if let rating = filmInfo.ratingImdb {
            ratingInfoLabel.setData("\(rating)")
        } else {
            ratingInfoLabel.setData("--")
        }
        if let year = filmInfo.year {
            yearInfoLabel.setData("\(year)")
        }
        if let filmLength = filmInfo.filmLength {
            lengthInfoLabel.setData("\(filmLength) Минут")
        }
        
        if filmInfo.isTicketsAvailable {
            statusInfoLabel.setData("Доступны")
        } else {
            statusInfoLabel.setData("Недоступны")
        }
    }
}
