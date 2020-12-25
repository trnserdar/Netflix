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
    private(set) var genres: [Genre] = []
    weak var coordinator: GenresCoordinator?
    
    override func loadView() {
        view = genresView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.genres

        genresView.searchBarTextDidChange = { [weak self] searchText in
            guard let self = self else { return }
            let filteredGenres = self.genres.filter( { $0.name.lowercased().contains(searchText.lowercased()) && !$0.name.contains("All") })
            self.genresView.filteredViewModels = !filteredGenres.isEmpty ? filteredGenres.map({ GenreViewModel(genre: $0) }) : self.genres.map({ GenreViewModel(genre: $0) })
        }
        
        genresView.genreSelected = { [weak self] genre in
            guard let self = self else { return }
            self.getNew100(genre: genre)
        }

        getGenres()
        
    }
    
    func getGenres() {
        netflixClient.getGenres { (genres, error) in
            guard let genres = genres,
                  genres.count > 0 else {
                return
            }
            
            self.genres = genres
            self.genresView.filteredViewModels = genres.filter({ !$0.name.contains("All") }).map({ GenreViewModel(genre: $0) })
        }
        
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.coordinator?.showResult(selectedGenre: genre, results: response)
        }
        
    }
    
}
