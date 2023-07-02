//
//  FilmInfoViewController.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 29.06.2023.
//

import UIKit
import SnapKit

// MARK: - MainViewController
final class FilmInfoViewController: UIViewController {
    // MARK: - Dependencies
    var output: FilmInfoViewOutput?
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
    
        collectionView.register(
            FilmMainInfoCell.self,
            forCellWithReuseIdentifier: FilmMainInfoCell.reuseIdentifier
        )
        collectionView.register(
            StaffInfoHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StaffInfoHeader.reuseIdentifier
        )
        collectionView.register(
            StaffInfoCell.self,
            forCellWithReuseIdentifier: StaffInfoCell.reuseIdentifier
        )
        collectionView.backgroundColor = UIColor(named: "AppBackground")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        
        return collectionView
        }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let sections = output?.getSections() ?? []
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            let layout = sections[sectionIndex].layoutSection()
            return layout
        }
        return layout
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoadEvent()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppearEvent()
    }
    
    // MARK: - Setups
    
    private func setup() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(named: "AppBackground")
        configureTitleItems()
        setConstraints()
    }
    
    private func configureTitleItems() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.title = "Детали"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(bookmarkButtonTapped)
        )
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Private
    @objc private func backButtonTapped() {
        output?.backButtonTapped()
    }
    
    @objc private func bookmarkButtonTapped() {
        output?.bookmarkButtonTapped()
    }
}

// MARK: - FilmInfoViewInput
extension FilmInfoViewController: FilmInfoViewInput {
    func reloadSection(_ section: Int) {
        DispatchQueue.main.async { [weak collectionView] in
            collectionView?.reloadSections(IndexSet(integer: section))
        }
    }
    
    func makeBookmarkUnfill() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
    }
    
    func makeBookmarkFill() {
        print("make fill")
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
    }
}

// MARK: - UICollectionViewDataSource
extension FilmInfoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output?.getSectionCount() ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return output?.getNumberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let presenter = output else { return UICollectionViewCell() }
        let cellReuseIdentifier = presenter.getReuseIdentifierForItemAt(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellReuseIdentifier,
            for: indexPath
        )
        presenter.configureCell(cell, at: indexPath)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let presenter = output else { return UICollectionReusableView() }
        let headerReuseIdentifier = presenter.getReuseIdentifierForHeader(indexPath: indexPath)
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerReuseIdentifier,
            for: indexPath
        )
        return header
    }
}
