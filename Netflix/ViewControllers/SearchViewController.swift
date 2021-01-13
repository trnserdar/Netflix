//
//  SearchViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    var netflixClient: NetflixClientProtocol = NetflixClient()
    private(set) var searchResults: [SearchResult] = []
    var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: ResultDetailing?

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
            self?.search(query: query)
        }
        
        searchView.resultSelected = { [weak self] searchResult in
            self?.coordinator?.showResultDetail(result: searchResult)
        }
        
        searchView.favoriteSelected = { [weak self] searchResult in
            self?.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            self?.searchView.viewModels = self?.searchView.viewModels.map({ SearchResultViewModel(searchResult: $0.searchResult, favorites: favorites) }) ?? []
        }
    
    }
    
    func search(query: String) {
        searchView.baseViewModel.isActivityIndicatorEnabled = true
        netflixClient.search(query: query, genreId: nil) { [weak self] (searchResults, error) in
            defer {
                DispatchQueue.main.async {
                    self?.searchView.baseViewModel.isActivityIndicatorEnabled = false
                    self?.searchView.viewModels = self?.searchResults.map({ SearchResultViewModel(searchResult: $0, favorites: self?.favoriteManager.favorites ?? []) }) ?? []
                }
            }
            self?.searchResults = searchResults ?? []
        }
        
    }
    
}
