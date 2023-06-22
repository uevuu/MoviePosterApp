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
    
    private lazy var bar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
        
    private lazy var premieresButton = RatingTypeButton(title: "Premieres")
    private lazy var topRatedButton = RatingTypeButton(title: "Top rated")
    private lazy var popularButton = RatingTypeButton(title: "Popular")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setupView() {
        premieresButton.addTarget(self, action: #selector(premieresButtonTapped), for: .touchUpInside)
        topRatedButton.addTarget(self, action: #selector(topRatedButtonTapped), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(popularButtonButtonTapped), for: .touchUpInside)
        addSubview(premieresButton)
        addSubview(topRatedButton)
        addSubview(popularButton)
        addSubview(bar)
        setConstraints()
    }
    
    @objc private func premieresButtonTapped() {
        let newX = premieresButton.frame.width * 0.18 + premieresButton.frame.minX
        UIView.animate(withDuration: 0.3) {
            self.bar.transform = CGAffineTransform(translationX: newX, y: 0)
        }
    }
    
    @objc private func topRatedButtonTapped() {
        let newX = topRatedButton.frame.width * 0.18 + topRatedButton.frame.minX
        UIView.animate(withDuration: 0.3) {
            self.bar.transform = CGAffineTransform(translationX: newX, y: 0)
        }
    }
    
    @objc private func popularButtonButtonTapped() {
        let newX = popularButton.frame.width * 0.18 + popularButton.frame.minX
        UIView.animate(withDuration: 0.3) {
            self.bar.transform = CGAffineTransform(translationX: newX, y: 0)
        }
    }
    
    func setConstraints() {
        premieresButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33)
            make.leading.equalToSuperview()
        }
        topRatedButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33)
            make.centerX.equalToSuperview()
        }
        popularButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33)
            make.trailing.equalToSuperview()
        }
        bar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalToSuperview().multipliedBy(0.21)
        }
    }
}

// MARK: - RatingTypeButton
final class RatingTypeButton: UIButton {    
    private lazy var ratingTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        ratingTypeLabel.text = title
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(ratingTypeLabel)
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        ratingTypeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
