//
//  MainTabBarController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
        let homeVC = createHomeNavigation()
        let aboutVC = createAboutNavigation()
        let favoriteVC = createFavoriteNavigation()

        viewControllers = [homeVC, favoriteVC, aboutVC]
    }

    private func createHomeNavigation() -> UINavigationController {

        let presenter = HomePresenter(
            homeUseCase: Injection().provideHome()
        )

        let homeVC = HomeViewController(presenter: presenter)

        let nav = UINavigationController(rootViewController: homeVC)

        let router = HomeRouter(navigationController: nav)
        presenter.attachRouter(router)

        nav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        return nav
    }

    private func createAboutNavigation() -> UINavigationController {
        let aboutViewController = AboutViewController(
            presenter: AboutPresenter(interactor: Injection().provideAbout())
        )

        let nav = UINavigationController(
            rootViewController: aboutViewController
        )
        nav.tabBarItem = UITabBarItem(
            title: "About",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        return nav
    }

    private func createFavoriteNavigation() -> UINavigationController {
        let router = FavoriteRouter()
        let presenter = FavoritePresenter(
            useCase: Injection().provideFavorite(),
            router: router
        )

        let vc = FavoriteViewController(presenter: presenter)

        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )

        return nav
    }

}
