//
//  StaffInfoHeader.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit

// MARK: - StaffInfoHeader
final class StaffInfoHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "StaffInfoHeaderReuseIdentifier"
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Персонал"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        addSubview(headerLabel)
        setConstraints()
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
    }
}
