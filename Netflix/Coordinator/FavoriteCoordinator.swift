//
//  FavoriteCoordinator.swift
//  Netflix
//
//  Created by SERDAR TURAN on 28.12.2020.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.coordinator = self
        let favoriteTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.favorite.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.favorite.rawValue), selectedImage: nil)
        favoritesViewController.tabBarItem = favoriteTabBarItem
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
}

extension FavoriteCoordinator: SearchResulting {
    
    func showResult(navigationTitle: String? = nil, results: [SearchResult]) {
        let searchResultViewController = SearchResultViewController()
        searchResultViewController.coordinator = self
        searchResultViewController.searchResults = results
        searchResultViewController.title = navigationTitle
        navigationController.pushViewController(searchResultViewController, animated: true)
        
    }
}

extension FavoriteCoordinator: ResultDetailing {
    
    func showResultDetail(result: SearchResult) {
        let resultDetailViewController = ResultDetailViewController()
        resultDetailViewController.coordinator = self
        resultDetailViewController.searchResult = result
        navigationController.pushViewController(resultDetailViewController, animated: true)
    }
}

extension FavoriteCoordinator: CastDetailing {
    
    func showCastDetail(person: Person) {
        let castViewController = CastViewController()
        castViewController.coordinator = self
        castViewController.person = person
        navigationController.pushViewController(castViewController, animated: true)
    }
}
