//
//  ProfileCoordinator.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        let profileTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.profile.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.profile.rawValue), selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
}
