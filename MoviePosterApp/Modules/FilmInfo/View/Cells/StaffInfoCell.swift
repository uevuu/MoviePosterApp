//
//  StaffInfoCell.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit

// MARK: - StaffInfoCell
final class StaffInfoCell: UICollectionViewCell {
    static let reuseIdentifier: String = "StaffInfoCellReuseIdentifier"
    
    private lazy var faceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = contentView.frame.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var personNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
        contentView.addSubview(faceImageView)
        contentView.addSubview(personNameLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        faceImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(contentView.snp.width)
        }
        personNameLabel.snp.makeConstraints { make in
            make.top.equalTo(faceImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
    func configureCell(
        imageUrlString: String,
        name: String
    ) {
        faceImageView.kf.setImage(with: URL(string: imageUrlString))
        personNameLabel.text = name
    }
}
