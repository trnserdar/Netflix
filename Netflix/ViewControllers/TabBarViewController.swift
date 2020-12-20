//
//  TabBarViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {
    
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
        let homeViewController = HomeViewController()
        let homeTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.home.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.home.rawValue), selectedImage: nil)
        homeViewController.tabBarItem = homeTabBarItem
        
        let genresViewController = GenresViewController()
        let genresTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.genres.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.genres.rawValue), selectedImage: nil)
        genresViewController.tabBarItem = genresTabBarItem
                
        let searchViewController = SearchViewController()
        let searchTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.genres.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.search.rawValue), selectedImage: nil)
        searchViewController.tabBarItem = searchTabBarItem
        
        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.genres.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.profile.rawValue), selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem
        
        viewControllers = [homeViewController, genresViewController, searchViewController, profileViewController]
        
    }

}
