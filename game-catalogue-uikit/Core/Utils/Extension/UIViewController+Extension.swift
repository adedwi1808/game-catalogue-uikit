//
//  UIViewController+Extension.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import UIKit

extension UIViewController {

    func showSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tag = 999
        spinner.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        spinner.startAnimating()
    }

    func hideSpinner() {
        view.viewWithTag(999)?.removeFromSuperview()
    }
}
