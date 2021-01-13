//
//  HomeViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    lazy var netflixClient: NetflixClientProtocol = NetflixClient()
    let group = DispatchGroup()
    let queue = DispatchQueue.global(qos: .utility)
    var newReleases: [SearchResult] = []
    var actions: [SearchResult] = []
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: (SearchResulting & ResultDetailing)?

    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.home

        listenEvents()
        configureNetworkOperations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        homeView.newReleaseView.showAllTapped = { [weak self] results in
            self?.coordinator?.showResult(navigationTitle: TextConstants.newReleases, results: results)
        }
        
        homeView.actionView.showAllTapped = { [weak self] results in
            self?.coordinator?.showResult(navigationTitle: TextConstants.crimeActionAdventure, results: results)
        }
        
        homeView.resultSelected = { [weak self] searchResult in
            self?.coordinator?.showResultDetail(result: searchResult)
        }
        
        homeView.favoriteSelected = { [weak self] searchResult in
            self?.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            self?.homeView.viewModel.newRelease.favorites = favorites
            self?.homeView.viewModel.action.favorites = favorites
        }
        
    }
    
    func configureNetworkOperations() {
        self.homeView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.getNewReleases()
        }
        
        queue.async(group: group) {
            self.group.enter()
            self.getNew100(genre: Genre(name: TextConstants.crimeActionAdventure, ids: [9584]))
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.homeView.baseViewModel.isActivityIndicatorEnabled = false
            self?.homeView.viewModel.newRelease.searchResults = self?.newReleases ?? []
            self?.homeView.viewModel.action.searchResults = self?.actions ?? []
        }
        
    }
    
    func getNewReleases() {
        netflixClient.newReleases(days: "7") { (response, error) in
            defer { self.group.leave() }
            guard let searchResults = response,
                  !searchResults.isEmpty else {
                return
            }
            
            self.newReleases = searchResults
        }
        
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
            defer { self.group.leave() }
            guard let searchResults = response,
                  !searchResults.isEmpty else {
                return
            }
            
            self.actions = searchResults
        }
        
    }
    
}
