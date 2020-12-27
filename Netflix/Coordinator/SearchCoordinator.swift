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

extension SearchCoordinator: SearchResulting {
    
    func showResult(selectedGenre: Genre?, results: [SearchResult]) {
        let searchResultViewController = SearchResultViewController()
        searchResultViewController.coordinator = self
        searchResultViewController.genre = selectedGenre
        searchResultViewController.searchResults = results
        navigationController.pushViewController(searchResultViewController, animated: true)
        
    }
}

extension SearchCoordinator: ResultDetailing {
    
    func showResultDetail(result: SearchResult) {
        let resultDetailViewController = ResultDetailViewController()
        resultDetailViewController.coordinator = self
        resultDetailViewController.searchResult = result
        navigationController.pushViewController(resultDetailViewController, animated: true)
    }
}

extension SearchCoordinator: CastDetailing {
    
    func showCastDetail(person: Person) {
        let castViewController = CastViewController()
        castViewController.coordinator = self
        castViewController.person = person
        navigationController.pushViewController(castViewController, animated: true)
    }
}
