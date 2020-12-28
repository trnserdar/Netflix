//
//  TabBarViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let homeCoordinator = HomeCoordinator(navigationController: MainNavigationController())
    let genresCoordinator = GenresCoordinator(navigationController: MainNavigationController())
    let searchCoordinator = SearchCoordinator(navigationController: MainNavigationController())
    let favoriteCoordinator = FavoriteCoordinator(navigationController: MainNavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        configureTabs()
    }
    
    func configureTabBar() {
        tabBar.barTintColor = StyleConstants.TabBar.barTintColor
        tabBar.tintColor = StyleConstants.TabBar.tintColor
        tabBar.unselectedItemTintColor = StyleConstants.TabBar.unselectedItemTintColor
        
    }
    
    func configureTabs() {
        homeCoordinator.start()
        genresCoordinator.start()
        searchCoordinator.start()
        favoriteCoordinator.start()
        viewControllers = [homeCoordinator.navigationController, genresCoordinator.navigationController, searchCoordinator.navigationController, favoriteCoordinator.navigationController]
        
    }

}
