//
//  SearchViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    lazy var netflixClient = NetflixClient()
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: SearchCoordinator?

    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.search

        listenEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        searchView.searchButtonTapped = { [weak self] query in
            guard let self = self else { return }
            self.search(query: query)
        }
        
        searchView.resultSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResult)
        }
        
        searchView.favoriteSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            guard let self = self else { return }
            self.searchView.viewModels = self.searchView.viewModels.map({ SearchResultViewModel(searchResult: $0.searchResult, favorites: favorites) })
        }
    
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }

            self.searchView.viewModels = response.map({ SearchResultViewModel(searchResult: $0, favorites: self.favoriteManager.favorites) })
        }
        
    }
}
