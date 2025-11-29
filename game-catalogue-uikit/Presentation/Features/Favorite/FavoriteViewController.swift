//
//  FavoriteViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit
import SkeletonView

class FavoriteViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    private let viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        let services: FavoriteServicesProtocol = FavoriteServices(networker: Networker(), realm: RealmManager())
        self.viewModel = FavoriteViewModel(services: services)
        super.init(coder: coder)
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showShimmer()
        loadLocaleData()
    }
    
    private func setupView() {
        setupNavigationBar()
        setupTableView()
        setupConstraint()
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite List"
    }
    
    private func setupTableView() {
        tableView.isSkeletonable = true
        tableView.separatorStyle = .none
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
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
    
    
    private func loadLocaleData() {
        Task {
            await viewModel.getLocaleGames()
        }
    }
    
    @objc private func handleRefresh() {
        loadLocaleData()
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
        if tableView.sk.isSkeletonActive { return }
        guard indexPath.row < viewModel.games.count else { return }
        
        let detailViewModel = viewModel.createDetailViewModel(for: indexPath.row)
        let gameDetailViewController = GameDetailViewController(viewModel: detailViewModel)
        gameDetailViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewModelProtocol {
    func onSuccess() {
        refreshControl.endRefreshing()
        tableView.hideSkeleton()
        tableView.reloadData()
        
        if !viewModel.games.isEmpty  {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func onFailed(message: String) {
        refreshControl.endRefreshing()
        let alertController = UIAlertController(
            title: "Failed to fetch data",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
        
        self.tableView.tableFooterView = nil
    }
    
    func onLoading(_ isLoading: Bool) {
        if isLoading {
            self.tableView.tableFooterView = createSpinnerFooter()
        } else {
            self.tableView.tableFooterView = nil
        }
    }
}

extension FavoriteViewController: SkeletonTableViewDataSource {
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
