//
//  HomeViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
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
        
        showShimmer()
        fetchGames()
    }
    
    private func setupView() {
        setupSearchBar()
        setupTableView()
        setupConstraint()
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Game List"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
    }
    
    private func setupTableView() {
        tableView.isSkeletonable = true
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isSkeletonable = true
        tableView.estimatedRowHeight = 116
        tableView.rowHeight = UITableView.automaticDimension
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
    
    private func showShimmer() {
        tableView.showAnimatedGradientSkeleton(
            usingGradient: SkeletonGradient(
                baseColor: UIColor(white: 0.82, alpha: 1.0),
                secondaryColor: UIColor(white: 0.92, alpha: 1.0)
            ),
            animation: nil,
            transition: .none
        )
    }
    
    private func fetchGames() {
        Task {
            await viewModel.getGames()
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        print("Hasil Query: \(query)")
    }
}

extension HomeViewController: UITableViewDataSource {
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

extension HomeViewController: UITableViewDelegate {
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
        let data: Game = viewModel.games[indexPath.row]
        let viewModel: GameDetailViewModel = GameDetailViewModel()
        viewModel.configureDataFromList(data: data)
        
        let gameDetailViewController: GameDetailViewController = GameDetailViewController(viewModel: viewModel)
        gameDetailViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
}


extension HomeViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        1
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        3
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        GameTableViewCell.name
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func onSuccess() {
        tableView.hideSkeleton()
        tableView.reloadData()
    }
    
    func onFailed(message: String) {
        
    }
}
