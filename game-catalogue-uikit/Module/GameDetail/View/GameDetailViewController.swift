//
//  GameDetailViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit

@MainActor
final class GameDetailViewController: UIViewController {

    enum PageSection: Int, CaseIterable {
        case header, rating, description
    }

    private let presenter: GameDetailPresenter

    private let tableView = UITableView()

    init(presenter: GameDetailPresenter, game: Game) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
        presenter.setInitialGame(game)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        self.presenter = GameDetailPresenter(
            useCase: Injection().provideGameDetail()
        )
        super.init(coder: coder)
        presenter.view = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.fetchGameDetail()
    }

    override var prefersStatusBarHidden: Bool { true }

    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = false

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(
            GameDetailHeaderTableViewCell.self,
            forCellReuseIdentifier: GameDetailHeaderTableViewCell.name
        )
        tableView.register(
            GameDetailRatingTableViewCell.self,
            forCellReuseIdentifier: GameDetailRatingTableViewCell.name
        )
        tableView.register(
            GameDetailDescriptionTableViewCell.self,
            forCellReuseIdentifier: GameDetailDescriptionTableViewCell.name
        )

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: -120
            ),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension GameDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        PageSection.allCases.count
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int { 1 }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        switch PageSection(rawValue: indexPath.section) {

        case .header:
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: GameDetailHeaderTableViewCell.name,
                    for: indexPath
                ) as? GameDetailHeaderTableViewCell
            cell?.configure(data: presenter.game)
            return cell ?? UITableViewCell()

        case .rating:
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: GameDetailRatingTableViewCell.name,
                    for: indexPath
                ) as? GameDetailRatingTableViewCell
            cell?.configure(
                data: presenter.game,
                isFavorited: presenter.isFavorited
            ) { [weak self] in
                self?.presenter.toggleFavorite()
            }
            return cell ?? UITableViewCell()

        case .description:
            let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: GameDetailDescriptionTableViewCell.name,
                    for: indexPath
                ) as? GameDetailDescriptionTableViewCell
            cell?.configure(data: presenter.game)
            return cell ?? UITableViewCell()

        default:
            return UITableViewCell()
        }
    }
}

extension GameDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch PageSection(rawValue: indexPath.section) {
        case .header:
            return 350
        case .rating:
            return 80
        case .description:
            return UITableView.automaticDimension
        default:
            return 44
        }
    }
}

extension GameDetailViewController: GameDetailViewProtocol {
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            showSpinner()
        } else {
            hideSpinner()
        }
    }

    func render(game: Game?, isFavorited: Bool) {
        tableView.reloadData()
    }

    func showError(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
