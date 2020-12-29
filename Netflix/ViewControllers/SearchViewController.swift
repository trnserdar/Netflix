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
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .utility)
    private var searchResults: [SearchResult] = []
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
            self.configureNetworkOperationForSearch(query: query)
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
    
    func configureNetworkOperationForSearch(query: String) {
        searchView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.search(query: query)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.searchView.baseViewModel.isActivityIndicatorEnabled = false
            self.searchView.viewModels = self.searchResults.map({ SearchResultViewModel(searchResult: $0, favorites: self.favoriteManager.favorites) })
        }
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
            defer { self.group.leave() }
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.searchResults = response
        }
        
    }
}
