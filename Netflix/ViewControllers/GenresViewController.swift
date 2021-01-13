//
//  GenresViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class GenresViewController: UIViewController {
    
    let genresView = GenresView()
    var netflixClient: NetflixClientProtocol = NetflixClient()
    var genres: [Genre] = []
    var searchResults: [SearchResult] = []
    weak var coordinator: SearchResulting?
    
    override func loadView() {
        view = genresView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.genres

        listenEvents()
        getGenres()
    }
    
    func listenEvents() {
        genresView.searchBarTextDidChange = { [weak self] searchText in
            let filteredGenres = self?.genres.filter( { $0.name.lowercased().contains(searchText.lowercased()) && !$0.name.contains("All") }) ?? []
            self?.genresView.filteredViewModels = !filteredGenres.isEmpty ? filteredGenres.map({ GenreViewModel(genre: $0) }) : self?.genres.map({ GenreViewModel(genre: $0) }) ?? []
        }
        
        genresView.genreSelected = { [weak self] genre in
            self?.getNew100(genre: genre)
        }

    }
    
    func getGenres() {
        genresView.baseViewModel.isActivityIndicatorEnabled = true
        netflixClient.getGenres { [weak self] (genres, error) in
            defer {
                DispatchQueue.main.async {
                    self?.genresView.baseViewModel.isActivityIndicatorEnabled = false
                    self?.genresView.filteredViewModels = self?.genres.filter({ !$0.name.contains("All") }).map({ GenreViewModel(genre: $0) }) ?? []
                }
            }
            self?.genres = genres ?? []
        }
        
    }

    func getNew100(genre: Genre) {
        genresView.baseViewModel.isActivityIndicatorEnabled = true
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { [weak self] (response, error) in
            defer {
                DispatchQueue.main.async {
                    self?.genresView.baseViewModel.isActivityIndicatorEnabled = false
                    self?.coordinator?.showResult(navigationTitle: genre.name, results: self?.searchResults ?? [])
                }
            }
            self?.searchResults = response ?? []
        }
        
    }
    
}
