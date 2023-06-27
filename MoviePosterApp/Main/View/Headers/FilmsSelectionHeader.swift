//
//  FilmsSelectionHeader.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 18.06.2023.
//

import UIKit

// MARK: - FilmsSelectionHeaderDelegate
protocol FilmsSelectionHeaderDelegate: AnyObject {
    func swipeToSection(_ section: Int)
}
// MARK: - FilmsSelectionHeader
final class FilmsSelectionHeader: UICollectionReusableView {
    static let reuseIdentifier: String = "FilmsSelectionHeaderReuseIdentifier"
    weak var delegate: FilmsSelectionHeaderDelegate?
    
    private lazy var bar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.frame = CGRect(
            x: self.frame.width * 0.33 * 0.18,
            y: self.frame.height - 4,
            width: self.frame.width * 0.21,
            height: 4
        )
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
    
    private func setupView() {
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
        delegate?.swipeToSection(0)
    }
    
    @objc private func topRatedButtonTapped() {
        delegate?.swipeToSection(1)
    }
    
    @objc private func popularButtonButtonTapped() {
        delegate?.swipeToSection(2)
    }
    
    private func setConstraints() {
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
    }
    
    func barScrollTo(_ type: BarSrollTo) {
        var newX: CGFloat = 0.0
        switch type {
        case .premieres:
            newX = premieresButton.frame.minX
        case .topRated:
            newX = topRatedButton.frame.minX
        case .popular:
            newX = popularButton.frame.minX
        }
        UIView.animate(withDuration: 0.3) {
            self.bar.transform = CGAffineTransform(translationX: newX, y: 0)
        }
    }
}

enum BarSrollTo {
    case premieres
    case topRated
    case popular
}
