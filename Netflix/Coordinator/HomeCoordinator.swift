//
//  HomeCoordinator.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        let homeTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.home.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.home.rawValue), selectedImage: nil)
        homeViewController.tabBarItem = homeTabBarItem
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
    
}
