//
//  SecondaryInfoView.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit
enum InfoViewType {
    case year
    case length
    case tickectStatus
    case rating
}

// MARK: - SecondaryInfoView
final class SecondaryInfoView: UIView {
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "SecondaryInfoColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "SecondaryInfoColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(_ type: InfoViewType) {
        super.init(frame: .zero)
        switch type {
        case .year:
            imageView.image = UIImage(systemName: "calendar")
            infoLabel.text = "? Год"
        case .length:
            imageView.image = UIImage(systemName: "clock")
            infoLabel.text = "? Минут"
        case .tickectStatus:
            imageView.image = UIImage(systemName: "ticket")
        case .rating:
            imageView.image = UIImage(systemName: "star")
            imageView.tintColor = UIColor(named: "OrangeColor")
            infoLabel.text = "--"
            infoLabel.textColor = UIColor(named: "OrangeColor")
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageView)
        addSubview(infoLabel)
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(_ data: String) {
        infoLabel.text = data
    }
}
