//
//  WatchListViewController.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import UIKit
import SnapKit

// MARK: - WatchListViewController
final class WatchListViewController: UIViewController {
    // MARK: - Dependencies
    var output: WatchListViewOutput?
    
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
        tableView.backgroundColor = UIColor(named: "AppBackground")
        view.backgroundColor = UIColor(named: "AppBackground")
        view.addSubview(tableView)
        configureTitleItems()
        setConstraints()
    }
    
    private func configureTitleItems() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.title = "Watch list"
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - WatchListViewInput
extension WatchListViewController: WatchListViewInput {
    func reloadView() {
        DispatchQueue.main.async { [weak tableView] in
            tableView?.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension WatchListViewController: UITableViewDataSource {
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

// MARK: - UITableViewDelegate
extension WatchListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output?.selectFilm(at: indexPath)
    }
}
