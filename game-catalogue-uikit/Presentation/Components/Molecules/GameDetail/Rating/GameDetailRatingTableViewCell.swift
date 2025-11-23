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
        view.backgroundColor = .systemGray2
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
        
        ratingSectionView.configure(rating: 4.42, numberOfVote: 999)
        
        favoriteSectionView.onTap = {
            print("Click: Favorite")
        }
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
            dividerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dividerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 4)
        ])
        
        NSLayoutConstraint.activate([
            favoriteSectionView.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            favoriteSectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            favoriteSectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favoriteSectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
}
