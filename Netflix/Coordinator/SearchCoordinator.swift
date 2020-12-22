//
//  SearchCoordinator.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        let searchTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.search.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.search.rawValue), selectedImage: nil)
        searchViewController.tabBarItem = searchTabBarItem
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
}
