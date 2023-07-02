//
//  AwaitFilmsSectionHeader.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit

// MARK: - AwaitFilmsSectionHeaderDelegate
protocol AwaitFilmsSectionHeaderDelegate: AnyObject {
    func searchButtonTapped()
}

// MARK: - AwaitFilmsSectionHeader
final class AwaitFilmsSectionHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "AwaitFilmsSectionHeaderReuseIdentifier"
    weak var delegate: AwaitFilmsSectionHeaderDelegate?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "AwaitFilmsHeader"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchButton = SearchButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setup() {
        searchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(headerLabel)
        addSubview(searchButton)
        setConstraints()
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(42)
            make.trailing.bottom.equalToSuperview().inset(12)
        }
    }
    
    @objc private func buttonTapped() {
        delegate?.searchButtonTapped()
    }
}
