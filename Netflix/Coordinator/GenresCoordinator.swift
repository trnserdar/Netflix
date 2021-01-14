//
//  GenresCoordinator.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class GenresCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let genresViewController = GenresViewController()
        genresViewController.coordinator = self
        let genresTabBarItem = UITabBarItem(title: StyleConstants.TabBar.TabBarTitle.genres.rawValue, image: UIImage(systemName: StyleConstants.TabBar.TabBarImage.genres.rawValue), selectedImage: nil)
        genresViewController.tabBarItem = genresTabBarItem
        navigationController.pushViewController(genresViewController, animated: true)
        
    }
    
}

extension GenresCoordinator: SearchResulting {
    
    func showResult(navigationTitle: String?, results: [SearchResult]) {
        let searchResultViewController = SearchResultViewController()
        searchResultViewController.coordinator = self
        searchResultViewController.searchResults = results
        searchResultViewController.title = navigationTitle
        navigationController.pushViewController(searchResultViewController, animated: true)
        
    }
}

extension GenresCoordinator: ResultDetailing {
    
    func showResultDetail(result: SearchResult) {
        let resultDetailViewController = ResultDetailViewController()
        resultDetailViewController.coordinator = self
        resultDetailViewController.searchResult = result
        navigationController.pushViewController(resultDetailViewController, animated: true)
    }
}

extension GenresCoordinator: CastDetailing {
    
    func showCastDetail(person: Person) {
        let castViewController = CastViewController()
        castViewController.coordinator = self
        castViewController.person = person
        navigationController.pushViewController(castViewController, animated: true)
    }
}

extension GenresCoordinator: ComingBack {
    
    func comingBack() {
        navigationController.popViewController(animated: true)
    }
}
