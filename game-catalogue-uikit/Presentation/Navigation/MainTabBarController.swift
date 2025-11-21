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
        let homeViewModel: HomeViewModel = HomeViewModel()
        let homeViewController: HomeViewController = HomeViewController(viewModel: homeViewModel)
        
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        return nav
    }
    
    private func createAboutNavigation() -> UINavigationController {
        let profileVC = AboutViewController()
        
        let nav = UINavigationController(rootViewController: profileVC)
        nav.tabBarItem = UITabBarItem(
            title: "About",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        return nav
    }
    
    private func createFavoriteNavigation() -> UINavigationController {
        let profileVC = FavoriteViewController()
        
        let nav = UINavigationController(rootViewController: profileVC)
        nav.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        return nav
    }
}
