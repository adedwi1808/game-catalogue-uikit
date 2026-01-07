//
//  FavoriteViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import SkeletonView
import UIKit

class FavoriteViewController: UIViewController {
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

    private let refreshControl = UIRefreshControl()
    private let presenter: FavoritePresenter

    init(presenter: FavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        presenter = FavoritePresenter(
            useCase: Injection().provideFavorite(),
            router: FavoriteRouter()
        )
        super.init(coder: coder)
        self.presenter.view = self
        setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showShimmer()
        presenter.getLocaleGames()
    }

    private func setupView() {
        setupNavigationBar()
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

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite List"
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
        presenter.getLocaleGames()
    }

    @objc private func handleRefresh() {
        loadLocaleData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        presenter.games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let data: Game = presenter.games[indexPath.row]
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: GameTableViewCell.name,
                for: indexPath
            ) as? GameTableViewCell
        cell?.configure(data: data)
        return cell ?? UITableViewCell()
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
        guard indexPath.row < presenter.games.count else { return }
        presenter.didSelectItem(
            at: indexPath.row,
            from: self
        )

    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func onSuccess() {
        refreshControl.endRefreshing()
        tableView.hideSkeleton()
        tableView.reloadData()

        if !presenter.games.isEmpty {
            tableView.scrollToRow(
                at: IndexPath(row: 0, section: 0),
                at: .top,
                animated: true
            )
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
