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
    private weak var selectionHeader: FilmsSelectionHeader?
    
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
            let layout = sections?[sectionIndex].layoutSection()
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)            
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        
        switch header {
        case let filmsSelectionHeader as FilmsSelectionHeader:
            filmsSelectionHeader.delegate = self
            selectionHeader = filmsSelectionHeader
        default:
            break
        }
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        output?.startDisplaying(indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        output?.finishDisplaying(indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        output?.selectItemAt(at: indexPath)
    }
}

// MARK: - FilmsSelectionHeaderDelegate
extension MainViewController: FilmsSelectionHeaderDelegate {
    func swipeToSection(_ section: Int) {
        output?.swipeSelectionTo(section: section)
    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func reloadSection(at section: Int) {
        collectionView.reloadSections(IndexSet(integer: section))
    }
    
    func reloadSelection(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func swipeTo(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    func selectionHeaderScrollTo(_ type: BarSrollTo) {
        selectionHeader?.barScrollTo(type)
    }
}
