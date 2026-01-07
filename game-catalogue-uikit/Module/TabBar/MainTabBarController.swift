//
//  MainTabBarController.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 20/11/25.
//


import UIKit

class MainTabBarController: UITabBarController {
    
    private let networker: NetworkerProtocol = Networker()
    private let realm: RealmManagerProtocol = RealmManager()
    
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
        let presenter = HomePresenter(homeUseCase: Injection().provideHome())
        let homeViewController: HomeViewController = HomeViewController(presenter: presenter)
        
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        return nav
    }
    
    private func createAboutNavigation() -> UINavigationController {
        let aboutViewModel: AboutViewModel = AboutViewModel()
        let aboutViewController = AboutViewController(viewModel: aboutViewModel)
        
        let nav = UINavigationController(rootViewController: aboutViewController)
        nav.tabBarItem = UITabBarItem(
            title: "About",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        return nav
    }
    
    private func createFavoriteNavigation() -> UINavigationController {
        let services: FavoriteServicesProtocol = FavoriteServices(networker: networker, realm: realm)
        let favoriteViewModel: FavoriteViewModel = FavoriteViewModel(services: services)
        let favoriteViewController = FavoriteViewController(viewModel: favoriteViewModel)
        
        let nav = UINavigationController(rootViewController: favoriteViewController)
        nav.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        return nav
    }
}
