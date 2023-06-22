//
//  MainViewController.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 11.06.2023.
//

import UIKit
import SnapKit

// MARK: - MainViewController
final class MainViewController: UIViewController {
    // MARK: - Dependencies
    var output: MainViewOutput?
    
    // MARK: - Properties
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
    
        collectionView.register(
            AwaitFilmsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AwaitFilmsSectionHeader.reuseIdentifier
        )
        collectionView.register(
            SelectionFilmCell.self,
            forCellWithReuseIdentifier: SelectionFilmCell.reuseIdentifier
        )
        collectionView.register(
            FilmsSelectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FilmsSelectionHeader.reuseIdentifier
        )
        collectionView.register(
            AwaitFilmCell.self,
            forCellWithReuseIdentifier: AwaitFilmCell.reuseIdentifier
        )
        collectionView.backgroundColor = UIColor(named: "AppBackground")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
        }()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let sections = output?.getSections()
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return sections?[sectionIndex].layoutSection()
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setup() {
        view.backgroundColor = UIColor(named: "AppBackground")
        view.addSubview(collectionView)
        setConstraints()
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
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
        return presenter.catchCellCreation(collectionView, cellForItemAt: indexPath)
    }
        
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let presenter = output else { return UICollectionReusableView() }
        return presenter.catchHeaderCreation(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func reloadSection(at section: Int) {
        collectionView.reloadSections(IndexSet(integer: section))
    }
}
