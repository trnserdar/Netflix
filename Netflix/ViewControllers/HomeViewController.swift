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
    weak var coordinator: HomeCoordinator?
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.home

        homeView.newReleaseView.showAllTapped = { [weak self] results in
            self?.coordinator?.showResult(selectedGenre: nil, results: results)
        }
        
        homeView.actionView.showAllTapped = { [weak self] results in
            self?.coordinator?.showResult(selectedGenre: Genre(name: TextConstants.crimeActionAdventure, ids: [9584]), results: results)
        }
        
        getNewReleases()
        getNew100(genre: Genre(name: TextConstants.crimeActionAdventure, ids: [9584]))
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
