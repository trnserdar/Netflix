//
//  FavoritesViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 28.12.2020.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favoriteView = SearchResultView()
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: FavoriteCoordinator?

    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.favorites
        listenEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        favoriteView.resultSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResult)
        }
        
        favoriteView.favoriteSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            guard let self = self else { return }
            let searchResults = favorites.map({ $0.nfinfo }).filter({ $0 != nil })
            self.favoriteView.viewModels = searchResults.filter({ $0 != nil }).map({ SearchResultViewModel(searchResult: $0!, favorites: favorites)})
        }

    }

}
