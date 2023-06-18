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
    
    @objc private func printButtonTapped() {
        output?.didPressedAction()
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
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AwaitFilmCell.reuseIdentifier,
            for: indexPath
        ) as? AwaitFilmCell else {
            fatalError("Error with getting SelectionFilmCell")
        }
        return cell
    }
        
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AwaitFilmsSectionHeader.reuseIdentifier,
                for: indexPath
            ) as? AwaitFilmsSectionHeader else {
                fatalError("Error with getting AwaitFilmsSectionHeader")
            }
            return header
        }
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FilmsSelectionHeader.reuseIdentifier,
            for: indexPath
        ) as? FilmsSelectionHeader else {
            fatalError("Error with getting FilmsSelectionHeader")
        }
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func showFormattedString(_ string: String) {
        print(string)
    }
}
