//
//  GameDetailDescriptionTableViewCell.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit

class GameDetailDescriptionTableViewCell: UITableViewCell {
    static let name: String = String(describing: GameDetailDescriptionTableViewCell.self)

    private let containerView: UIView = UIView()

    private let labelLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        label.text = "Description:"
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints()
    }

    private func setupConstraints() {
        [labelLabel, descriptionLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            labelLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labelLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            labelLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: labelLabel.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    func configure(data: Game?) {
        guard let data else { return }
        descriptionLabel.text = data.description ?? ""
    }
}
