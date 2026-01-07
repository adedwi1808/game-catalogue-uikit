//
//  HomeRouter.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import UIKit

protocol HomeRouterProtocol {
    func makeDetailPage(for game: Game)
}

final class HomeRouter: HomeRouterProtocol {

    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func makeDetailPage(for game: Game) {
        let presenter = GameDetailPresenter(
            useCase: Injection().provideGameDetail()
        )

        let gameVC = GameDetailViewController(
            presenter: presenter,
            game: game
        )

        gameVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
