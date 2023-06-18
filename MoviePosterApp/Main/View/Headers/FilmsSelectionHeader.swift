//
//  FilmsSelectionHeader.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit

// MARK: - FilmsSelectionHeader
final class FilmsSelectionHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "FilmsSelectionHeaderReuseIdentifier"
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "FilmsSelectionHeader"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        addSubview(headerLabel)
    }
    
    func setConstraint() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
    }
}
