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
        }
        setup()
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
    
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
            make.leading.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().inset(5)
        }
    }
    
    func setData(_ data: String) {
        infoLabel.text = data
    }
}
