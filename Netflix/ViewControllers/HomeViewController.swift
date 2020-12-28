//
//  HomeViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    lazy var netflixClient = NetflixClient()
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: HomeCoordinator?
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.home

        listenEvents()
        getNewReleases()
        getNew100(genre: Genre(name: TextConstants.crimeActionAdventure, ids: [9584]))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        homeView.newReleaseView.showAllTapped = { [weak self] results in
            guard let self = self else { return }
            self.coordinator?.showResult(navigationTitle: TextConstants.newReleases, results: results)
        }
        
        homeView.actionView.showAllTapped = { [weak self] results in
            guard let self = self else { return }
            self.coordinator?.showResult(navigationTitle: TextConstants.crimeActionAdventure, results: results)
        }
        
        homeView.resultSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResult)
        }
        
        homeView.favoriteSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            guard let self = self else { return }
            self.homeView.viewModel.newRelease.favorites = favorites
            self.homeView.viewModel.action.favorites = favorites
        }
        
    }
    
    func getNewReleases() {
        netflixClient.newReleases(days: "7") { (response, error) in
            
            guard let searchResults = response,
                  !searchResults.isEmpty else {
                return
            }
            
            self.homeView.viewModel.newRelease.searchResults = searchResults
        }
        
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
                        
            guard let searchResults = response,
                  !searchResults.isEmpty else {
                return
            }
            
            self.homeView.viewModel.action.searchResults = searchResults
        }
        
    }

}
