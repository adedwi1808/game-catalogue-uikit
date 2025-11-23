//
//  FavoriteViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit

class FavoriteViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private let viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLocaleData()
    }
    
    private func setupView() {
        setupNavigationBar()
        setupTableView()
        setupConstraint()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite List"
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            GameTableViewCell.self,
            forCellReuseIdentifier: GameTableViewCell.name
        )
    }
    
    private func setupConstraint() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadLocaleData() {
        Task {
            await viewModel.getLocaleGames()
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: Game = viewModel.games[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GameTableViewCell.name,
            for: indexPath
        ) as! GameTableViewCell
        cell.configure(data: data)
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        10
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        130
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard indexPath.row < viewModel.games.count else { return }
        
        let detailViewModel = viewModel.createDetailViewModel(for: indexPath.row)
        let gameDetailViewController = GameDetailViewController(viewModel: detailViewModel)
        gameDetailViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewModelProtocol {
    func onSuccess() {
        tableView.reloadData()
    }
    
    func onFailed(message: String) {
        let alertController = UIAlertController(
            title: "Failed to fetch data",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
        
        self.tableView.tableFooterView = nil
    }
}
