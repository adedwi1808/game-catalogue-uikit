//
//  GameDetailFavoriteSectionView.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import UIKit

class GameDetailFavoriteSectionView: UIView {
    private let containerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    private let favoriteSectionHeaderView: UIView = UIView()
    private let favoriteLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Favorite"
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    private let heartImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .gray
        return imageView
    }()
    private let numberOfPeopleFavoriteLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        self.addSubview(containerButton)
        containerButton.translatesAutoresizingMaskIntoConstraints = false
        
        [favoriteSectionHeaderView, numberOfPeopleFavoriteLabel].forEach {
            containerButton.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [heartImageView, favoriteLabel].forEach {
            favoriteSectionHeaderView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints()
        
        favoriteSectionHeaderView.isUserInteractionEnabled = false
        favoriteLabel.isUserInteractionEnabled = false
        heartImageView.isUserInteractionEnabled = false
        numberOfPeopleFavoriteLabel.isUserInteractionEnabled = false
        containerButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            favoriteSectionHeaderView.leadingAnchor.constraint(equalTo: containerButton.leadingAnchor),
            favoriteSectionHeaderView.trailingAnchor.constraint(equalTo: containerButton.trailingAnchor),
            favoriteSectionHeaderView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.leadingAnchor.constraint(lessThanOrEqualTo: favoriteSectionHeaderView.leadingAnchor, constant: 36),
            heartImageView.topAnchor.constraint(equalTo: favoriteSectionHeaderView.topAnchor),
            heartImageView.bottomAnchor.constraint(equalTo: favoriteSectionHeaderView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            favoriteLabel.leadingAnchor.constraint(equalTo: heartImageView.trailingAnchor, constant: 6),
            favoriteLabel.trailingAnchor.constraint(lessThanOrEqualTo: favoriteSectionHeaderView.trailingAnchor, constant: -36),
            favoriteLabel.centerYAnchor.constraint(equalTo: heartImageView.centerYAnchor),
            favoriteLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            numberOfPeopleFavoriteLabel.topAnchor.constraint(equalTo: favoriteSectionHeaderView.bottomAnchor),
            numberOfPeopleFavoriteLabel.leadingAnchor.constraint(equalTo: containerButton.leadingAnchor),
            numberOfPeopleFavoriteLabel.trailingAnchor.constraint(equalTo: containerButton.trailingAnchor),
            numberOfPeopleFavoriteLabel.bottomAnchor.constraint(equalTo:  containerButton.bottomAnchor)
        ])
    }
    
    @objc private func didTap() {
        onTap?()
    }
    
    func configure(data: Game?, isAdded: Bool = false) {
        guard let data else { return }
        var numberOfPeopleAdd: Int = data.added ?? 0
        if isAdded {
            numberOfPeopleAdd += 1
        }
        numberOfPeopleFavoriteLabel.text = "\(numberOfPeopleAdd) Orang"
        
        heartImageView.tintColor = isAdded ? .systemPink : .gray
        self.layoutIfNeeded()
    }
}
