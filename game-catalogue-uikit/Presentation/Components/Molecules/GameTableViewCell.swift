//
//  GameTableViewCell.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit
import Kingfisher
import SkeletonView

class GameTableViewCell: UITableViewCell {
    static let name: String = String(describing: GameTableViewCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .raisinBlack
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var nameLabel = buildLabel(size: 16, weight: .heavy)
    private lazy var genresLabel = buildLabel(size: 14, weight: .medium)
    private lazy var releaseDateLabel = buildLabel(size: 14, weight: .medium)
    private lazy var ratingLabel = buildLabel(size: 12, weight: .black)
    
    private lazy var centerContainerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            genresLabel,
            releaseDateLabel,
            platformStackView
        ])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    private let ratingContainerView: UIView = {
        let container: UIView = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        return container
    }()
    
    private lazy var platformStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.distribution = .fill
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
        nameLabel.text = nil
        genresLabel.text = nil
        releaseDateLabel.text = nil
        ratingLabel.text = nil
        platformStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        enableSkeleton(on: [
            self, contentView, containerView,
            centerContainerView, posterImageView, nameLabel, genresLabel,
            releaseDateLabel, platformStackView, ratingContainerView
        ])
        
        nameLabel.numberOfLines = 2
        genresLabel.textColor = .lightGray
        releaseDateLabel.textColor = .lightGray
        ratingLabel.textColor = .raisinBlack
        ratingLabel.textAlignment = .center
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(containerView)
        
        [posterImageView, centerContainerView, ratingContainerView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 84),
            
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6),
        ])
        
        NSLayoutConstraint.activate([
            centerContainerView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            centerContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            centerContainerView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -6),
        ])
        
        NSLayoutConstraint.activate([
            ratingContainerView.leadingAnchor.constraint(equalTo: centerContainerView.trailingAnchor, constant: 10),
            ratingContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            ratingContainerView.widthAnchor.constraint(equalToConstant: 36),
            ratingContainerView.heightAnchor.constraint(equalToConstant: 36),
            ratingContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        ratingContainerView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: ratingContainerView.leadingAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainerView.trailingAnchor, constant: -5),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainerView.centerYAnchor)
        ])
    }
    
    private func buildLabel(size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: size, weight: weight)
        label.textColor = .white
        label.linesCornerRadius = 4
        return label
    }
    
    func configure(
        data: Game
    ) {
        let genres: String = data.genres.map {$0.name}.joined(separator: ", ")
        let rating: String = String(format: "%.1f", data.rating ?? 0.0)
        let platformNames: [String] = data.platforms.map {$0.slug}
        let platforms: [Platform] = platformNames.compactMap { Platform(rawValue: $0)}
        
        if let backgroundImage = data.backgroundImage,
           let url = URL(string: backgroundImage) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "photo.trianglebadge.exclamationmark")!.withTintColor(.raisinBlack)
        }
        
        nameLabel.text = data.name
        genresLabel.text = "Genres: \(genres)"
        releaseDateLabel.text = "Release Date: \(data.released)"
        ratingLabel.text = rating
        updatePlatforms(platforms)
    }
    
    private func updatePlatforms(_ platforms: [Platform]) {
        platformStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        platformStackView.layoutIfNeeded()
        
        for platform in platforms {
            let icon = UIImageView(image: UIImage(named: platform.assetName))
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.widthAnchor.constraint(equalToConstant: 14).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 14).isActive = true
            platformStackView.addArrangedSubview(icon)
        }
    }
    
    private func enableSkeleton(on views: [UIView]) {
        views.forEach { $0.isSkeletonable = true }
    }
    
}
