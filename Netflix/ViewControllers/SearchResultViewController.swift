//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searchResultView = SearchResultView()
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    var searchResults: [SearchResult] = [] {
        didSet {
            searchResultView.viewModels = searchResults.map({ SearchResultViewModel(searchResult: $0, favorites: favoriteManager.favorites) })
        }
    }
    weak var coordinator: ResultDetailing?

    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        searchResultView.resultSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResult)
        }
        
        searchResultView.favoriteSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            guard let self = self else { return }
            self.searchResultView.viewModels = self.searchResultView.viewModels.map({ SearchResultViewModel(searchResult: $0.searchResult, favorites: favorites)})
        }
        
    }
    
}
