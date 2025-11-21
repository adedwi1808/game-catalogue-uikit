//
//  AboutViewController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit
import Kingfisher

class AboutViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = 55
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabelView: UILabel = {
        let label = UILabel()
        label.text = "Ade Dwi Prayitno"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21, weight: .black)
        return label
    }()
    
    private let emailLabelView: UILabel = {
        let label = UILabel()
        label.text = "adedwip1808@gmail.com"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let viewModel: AboutViewModel
    
    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = AboutViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        loadImage()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "About Me"
    }
    
    private func setupView() {
        [imageView, nameLabelView, emailLabelView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.screenHeight / 3),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            nameLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            emailLabelView.topAnchor.constraint(equalTo: nameLabelView.bottomAnchor, constant: 16),
            emailLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    private func loadImage() {
        guard let imageURL = viewModel.imageURL else {
            return
        }
        imageView.kf.setImage(with: imageURL)
    }
}
