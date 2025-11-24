//
//  GameDetailHeaderTableViewCell.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit
import Kingfisher

class GameDetailHeaderTableViewCell: UITableViewCell {
    static let name: String = String(describing: GameDetailHeaderTableViewCell.self)
    
    private let mainContainerView: UIView = UIView()
    
    private let backgroundImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let gameProfileStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    private let platformStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 6
        return stackView
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
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(mainContainerView)
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        [backgroundImageView, posterImageView, nameLabel, gameProfileStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainContainerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5),
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 7/10),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            gameProfileStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            gameProfileStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            gameProfileStackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func buildProfileTextLabel(genres: String, releaseDate: String, developers: String) {
        gameProfileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        gameProfileStackView.layoutIfNeeded()
        platformStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        platformStackView.layoutIfNeeded()
        
        let genreView = createProfileTextLabelElement(labelText: "Genre", valuText: genres)
        let releaseDateView = createProfileTextLabelElement(labelText: "Release Date", valuText: releaseDate)
        let developersView = createProfileTextLabelElement(labelText: "Developers", valuText: developers)
        
        [genreView, releaseDateView, developersView, platformStackView].forEach {
            gameProfileStackView.addArrangedSubview($0)
        }
    }
    
    private func createProfileTextLabelElement(labelText: String, valuText: String) -> UIStackView {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = labelText
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 92).isActive = true
        stackView.addArrangedSubview(label)
        
        let valueLabel: UILabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        valueLabel.text = valuText
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(valueLabel)
        
        return stackView
    }
    
    func configure(data: Game?) {
        guard let data else { return }
        let genres: String = data.genres.compactMap { $0.name }.joined(separator: ", ")
        buildProfileTextLabel(genres: genres, releaseDate: data.released, developers: data.developers ?? "")
        
        nameLabel.text = data.name
        
        updatePlatforms(data.platforms)
        setImage(stringURL: data.backgroundImage)
    }
    
    private func setImage(stringURL: String?) {
        if let stringURL,
           let imageURL = URL(string: stringURL) {
            backgroundImageView.kf.setImage(with: imageURL)
            posterImageView.kf.setImage(with: imageURL)
        }
    }
    
    private func updatePlatforms(_ platforms: [PlatformElement]) {
        let platformNames: [String] = platforms.map {$0.slug}
        let platformsMapped: [Platform] = platformNames.compactMap { Platform(rawValue: $0)}
        platformStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for platform in platformsMapped {
            let icon = UIImageView(image: UIImage(named: platform.assetName))
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                icon.widthAnchor.constraint(equalToConstant: 16),
                icon.heightAnchor.constraint(equalToConstant: 16)
            ])
            
            platformStackView.addArrangedSubview(icon)
        }
        
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        
        platformStackView.addArrangedSubview(spacerView)
        platformStackView.layoutIfNeeded()
    }
}
