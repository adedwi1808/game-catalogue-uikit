//
//  HomeViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import SkeletonView
import UIKit

class HomeViewController: UIViewController {

    private let searchController = UISearchController(
        searchResultsController: nil
    )
    private let refreshControl = UIRefreshControl()

    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        return tableView
    }()

    private let presenter: HomePresenter

    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.presenter = HomePresenter(homeUseCase: Injection().provideHome())
        super.init(coder: coder)
        presenter.attachView(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showShimmer()
        presenter.loadInitial()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setupView() {
        setupSearchBar()
        setupTableView()
        setupConstraint()
    }

    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        )
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
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

        tableView.refreshControl = refreshControl
        refreshControl.addTarget(
            self,
            action: #selector(handleRefresh),
            for: .valueChanged
        )

        tableView.delegate = self
        tableView.dataSource = self

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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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

    @objc private func handleRefresh() {
        presenter.refresh()
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchQueryChanged(
            searchController.searchBar.text ?? ""
        )
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.games.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: GameTableViewCell.name,
                for: indexPath
            ) as! GameTableViewCell

        cell.configure(data: presenter.games[indexPath.row])
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
        if tableView.sk.isSkeletonActive { return }
        guard indexPath.row < presenter.games.count else { return }

        presenter.navigateToDetail(index: indexPath.row)
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == presenter.games.count - 1 {
            presenter.loadNextPage()
        }
    }
}

extension HomeViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int { 1 }
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { 3 }
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    )
        -> ReusableCellIdentifier
    {
        GameTableViewCell.name
    }
}

extension HomeViewController: HomeViewProtocol {

    func onLoading(_ isLoading: Bool) {
        isLoading
            ? tableView.showAnimatedGradientSkeleton()
            : tableView.hideSkeleton()
    }

    func onSuccess() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }

    func onFailed(message: String) {
        refreshControl.endRefreshing()
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
