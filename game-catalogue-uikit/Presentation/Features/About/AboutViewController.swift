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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21, weight: .black)
        return label
    }()
    
    private let emailLabelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.font = .systemFont(ofSize: 21, weight: .bold)
        textField.textAlignment = .center
        textField.isHidden = true
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.font = .systemFont(ofSize: 16)
        textField.textAlignment = .center
        textField.isHidden = true
        return textField
    }()
    
    
    private let editBarButtonItem: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem()
        button.image = UIImage(systemName: "square.and.pencil")
        return button
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
        nameLabelView.text  = viewModel.name
        emailLabelView.text = viewModel.email
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "About Me"
        navigationItem.rightBarButtonItem = editBarButtonItem
        editBarButtonItem.target = self
        editBarButtonItem.action = #selector(editButtonAction)
    }
    
    private func setupView() {
        [imageView, nameLabelView, emailLabelView, nameTextField, emailTextField].forEach {
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
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
    }
    
    private func loadImage() {
        guard let imageURL = viewModel.imageURL else {
            return
        }
        imageView.kf.setImage(with: imageURL)
    }
    
    @objc private func editButtonAction() {
        if viewModel.isEditingProfile {
            saveProfile()
        } else {
            enterEditMode()
        }
        viewModel.isEditingProfile.toggle()
    }
    
    private func enterEditMode() {
        editBarButtonItem.image = nil
        editBarButtonItem.title = "Save"
        
        nameTextField.text = nameLabelView.text
        emailTextField.text = emailLabelView.text
        
        nameTextField.isHidden = false
        emailTextField.isHidden = false
        
        nameLabelView.isHidden = true
        emailLabelView.isHidden = true
        
        nameTextField.becomeFirstResponder()
    }
    
    private func saveProfile() {
        editBarButtonItem.image = UIImage(systemName: "square.and.pencil")
        editBarButtonItem.title = nil
        
        let newName = nameTextField.text ?? ""
        let newEmail = emailTextField.text ?? ""
        
        viewModel.name = newName
        viewModel.email = newEmail
        
        nameLabelView.text = newName
        emailLabelView.text = newEmail
        
        nameTextField.isHidden = true
        emailTextField.isHidden = true
        
        nameLabelView.isHidden = false
        emailLabelView.isHidden = false
        
        view.endEditing(true)
    }
    
}
