//
//  GameDetailRatingSectionView.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 22/11/25.
//

import UIKit

class GameDetailRatingSectionView: UIView {
    private let containerView: UIView = UIView()
    private let ratingSectionHeaderView: UIView = UIView()
    private let ratingValueLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .tangerineYellow
        return label
    }()
    private let starStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberOfVoteLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
        
        [ratingSectionHeaderView, numberOfVoteLabel].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [ratingValueLabel, starStackView].forEach {
            ratingSectionHeaderView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            ratingSectionHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            ratingSectionHeaderView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ratingSectionHeaderView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            ratingValueLabel.leadingAnchor.constraint(lessThanOrEqualTo: ratingSectionHeaderView.leadingAnchor, constant: 36),
            ratingValueLabel.topAnchor.constraint(equalTo: ratingSectionHeaderView.topAnchor),
            ratingValueLabel.bottomAnchor.constraint(equalTo: ratingSectionHeaderView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            starStackView.leadingAnchor.constraint(equalTo: ratingValueLabel.trailingAnchor, constant: 6),
            starStackView.trailingAnchor.constraint(lessThanOrEqualTo: ratingSectionHeaderView.trailingAnchor, constant: 36),
            starStackView.centerYAnchor.constraint(equalTo: ratingValueLabel.centerYAnchor),
            starStackView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            numberOfVoteLabel.topAnchor.constraint(equalTo: ratingSectionHeaderView.bottomAnchor),
            numberOfVoteLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            numberOfVoteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            numberOfVoteLabel.bottomAnchor.constraint(equalTo:  containerView.bottomAnchor)
        ])
    }
    
    private func updateStars(_ rating: Double) {
        starStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let numberOfStarFilled: Int = Int(rating)
        
        for index in 1...5 {
            let icon = UIImageView(image: UIImage(systemName: "star.fill"))
            icon.contentMode = .scaleAspectFit
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.tintColor = index <= numberOfStarFilled ? .tangerineYellow : .systemGray2
            
            NSLayoutConstraint.activate([
                icon.widthAnchor.constraint(equalToConstant: 14),
                icon.heightAnchor.constraint(equalToConstant: 14)
            ])
            
            starStackView.addArrangedSubview(icon)
        }
        
        starStackView.layoutIfNeeded()
    }
    
    func configure(rating: Double, numberOfVote: Int) {
        ratingValueLabel.text = "\(rating)"
        numberOfVoteLabel.text = "\(numberOfVote) Vote"
        updateStars(rating)
        
        self.layoutIfNeeded()
    }
}
