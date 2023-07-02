//
//  SearchViewController.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import UIKit
import SnapKit

// MARK: - SearchViewController
final class SearchViewController: UIViewController {
    // MARK: - Dependencies
    var output: SearchViewOutput?
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            FilmTableViewCell.self,
            forCellReuseIdentifier: FilmTableViewCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.textColor = .white
        searhBar.searchTextField.tintColor = .white
        searhBar.searchTextField.leftView = nil
        searhBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите название",
            attributes: [
                .foregroundColor: UIColor(named: "SearchTitle") ?? UIColor.gray
            ]
        )
        searhBar.delegate = self
        searhBar.becomeFirstResponder()
        return searhBar
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoadEvent()
        setup()
    }

    // MARK: - Setups
    
    private func setup() {
        tableView.backgroundColor = UIColor(named: "AppBackground")
        view.backgroundColor = UIColor(named: "AppBackground")
        view.addSubview(tableView)
        configureTitleItems()
        setConstraints()
    }
    
    private func configureTitleItems() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.titleView = searchBar
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func backButtonTapped() {
        output?.backButtonTapped()
    }
}

// MARK: - SearchViewInput
extension SearchViewController: SearchViewInput {
    func reloadView() {
        DispatchQueue.main.async { [weak tableView] in
            tableView?.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getFilmsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = output else { return UITableViewCell() }
        let cellReuseIdentifier = presenter.getReuseIdentifierForItemAt(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdentifier,
            for: indexPath
        )
        presenter.configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.handleTextInput(searchText)
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output?.selectFilm(at: indexPath)
    }
}
