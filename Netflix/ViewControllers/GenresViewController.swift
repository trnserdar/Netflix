//
//  GenresViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class GenresViewController: UIViewController {
    
    let genresView = GenresView()
    lazy var netflixClient = NetflixClient()
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .utility)
    private var genres: [Genre] = []
    private var searchResults: [SearchResult] = []
    weak var coordinator: GenresCoordinator?
    
    override func loadView() {
        view = genresView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.genres

        listenEvents()
        configureNetworkOperationForGenres()
    }
    
    func listenEvents() {
        genresView.searchBarTextDidChange = { [weak self] searchText in
            guard let self = self else { return }
            let filteredGenres = self.genres.filter( { $0.name.lowercased().contains(searchText.lowercased()) && !$0.name.contains("All") })
            self.genresView.filteredViewModels = !filteredGenres.isEmpty ? filteredGenres.map({ GenreViewModel(genre: $0) }) : self.genres.map({ GenreViewModel(genre: $0) })
        }
        
        genresView.genreSelected = { [weak self] genre in
            guard let self = self else { return }
            self.configureNetworkOperation(genre: genre)
        }

    }
    
    func configureNetworkOperationForGenres() {
        genresView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.getGenres()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.genresView.baseViewModel.isActivityIndicatorEnabled = false
            self.genresView.filteredViewModels = self.genres.filter({ !$0.name.contains("All") }).map({ GenreViewModel(genre: $0) })
        }
    }
    
    func getGenres() {
        netflixClient.getGenres { (genres, error) in
            defer { self.group.leave() }
            guard let genres = genres,
                  genres.count > 0 else {
                return
            }
            
            self.genres = genres
        }
        
    }
    
    func configureNetworkOperation(genre: Genre) {
        genresView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.getNew100(genre: genre)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.genresView.baseViewModel.isActivityIndicatorEnabled = false
            self.coordinator?.showResult(navigationTitle: genre.name, results: self.searchResults)
        }
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
            defer { self.group.leave() }
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.searchResults = response
        }
        
    }
    
}
