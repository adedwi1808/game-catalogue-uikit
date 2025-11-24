//
//  GameDetailRatingTableViewCell.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import UIKit

class GameDetailRatingTableViewCell: UITableViewCell {
    static let name: String = String(describing: GameDetailRatingTableViewCell.self)
    
    private let containerView: UIView = UIView()
    private let ratingSectionView: GameDetailRatingSectionView = GameDetailRatingSectionView()
    private let favoriteSectionView: GameDetailFavoriteSectionView = GameDetailFavoriteSectionView()
    private let dividerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .divider
        return view
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
        setupConstraint()
    }
    
    private func setupConstraint() {
        [ratingSectionView, dividerView, favoriteSectionView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            ratingSectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            ratingSectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            ratingSectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ratingSectionView.widthAnchor.constraint(equalToConstant: UIScreen.screenWidth / 2 - 4),
        ])
        
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: ratingSectionView.trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            dividerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            dividerView.widthAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            favoriteSectionView.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            favoriteSectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            favoriteSectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favoriteSectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func configure(data: Game?, isFavorited: Bool, onFavoriteTapped: (() -> Void)?) {
        guard let data else { return }
        ratingSectionView.configure(rating: data.rating ?? 0.0, numberOfVote: data.ratingCount ?? 0)
        favoriteSectionView.configure(data: data, isFavorited: isFavorited, onFavoriteTapped: onFavoriteTapped)
    }
    
}
