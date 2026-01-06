//
//  GameDetailViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit

class GameDetailViewController: UIViewController {
    enum PageSection: Int, CaseIterable {
        case header = 0, rating = 1, description = 2
    }
    
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        return tableView
    }()
    
    private let viewModel: GameDetailViewModel
    
    init(viewModel: GameDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        let services: GameDetailServices = GameDetailServices(networker: Networker(), realm: RealmManager())
        self.viewModel = GameDetailViewModel(services: services)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupNavigationBar()
        setupView()
        
        fetchGameDetail()
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GameDetailHeaderTableViewCell.self, forCellReuseIdentifier: GameDetailHeaderTableViewCell.name)
        tableView.register(GameDetailRatingTableViewCell.self, forCellReuseIdentifier: GameDetailRatingTableViewCell.name)
        tableView.register(GameDetailDescriptionTableViewCell.self, forCellReuseIdentifier: GameDetailDescriptionTableViewCell.name)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -120),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func fetchGameDetail() {
        Task {
            await viewModel.getGameDetail()
        }
    }
}

extension GameDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        PageSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch PageSection(rawValue: indexPath.section) {
        case .header:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GameDetailHeaderTableViewCell.name,
                for: indexPath
            ) as? GameDetailHeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(data: viewModel.data)
            return cell
            
        case .rating:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GameDetailRatingTableViewCell.name,
                for: indexPath
            ) as? GameDetailRatingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(data: viewModel.data, isFavorited: viewModel.isFavorited) { [weak self] in
                guard let self else { return }
                viewModel.toggleFavorite()
            }
            return cell
            
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: GameDetailDescriptionTableViewCell.name,
                for: indexPath
            ) as? GameDetailDescriptionTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(data: viewModel.data)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension GameDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

extension GameDetailViewController: GameDetailViewModelProtocol {
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
    }
}
