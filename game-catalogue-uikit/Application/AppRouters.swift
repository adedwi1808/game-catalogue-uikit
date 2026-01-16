import UIKit
import Core
import Home
import Favorite
import GameDetail

@MainActor
final class AppHomeRouter: HomeRouterProtocol {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func makeDetailPage(for game: Game, from view: UIViewController) {
        let presenter = GameDetailPresenter(
            useCase: Injection().provideGameDetail()
        )

        let gameVC = GameDetailViewController(
            presenter: presenter,
            game: game
        )

        gameVC.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(gameVC, animated: true)
    }
}

@MainActor
final class AppFavoriteRouter: FavoriteRouterProtocol {

    func navigateToDetail(from view: UIViewController, game: Game) {
        let presenter = GameDetailPresenter(
            useCase: Injection().provideGameDetail()
        )

        let detailVC = GameDetailViewController(
            presenter: presenter,
            game: game
        )

        detailVC.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
