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
    private(set) var genres: [Genre] = [] {
        didSet {
            self.filteredViewModels = genres.filter({ !$0.name.contains("All") }).map({ GenreViewModel(genre: $0) })
        }
    }
    private(set) var filteredViewModels: [GenreViewModel] = [] {
        didSet {
            self.genresView.tableView.reloadData()
        }
    }
    
    weak var coordinator: GenresCoordinator?
    
    override func loadView() {
        view = genresView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextConstants.genres
        configureDelegates()
        getGenres()
        
    }
    
    func configureDelegates() {
        genresView.tableView.delegate = self
        genresView.tableView.dataSource = self
        genresView.searchBar.delegate = self
        
    }
    
    func getGenres() {
        netflixClient.getGenres { (genres, error) in
            guard let genres = genres,
                  genres.count > 0 else {
                return
            }
            
            self.genres = genres
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

extension GenresViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredGenres = genres.filter( { $0.name.lowercased().contains(searchText.lowercased()) && !$0.name.contains("All") })
        self.filteredViewModels = !filteredGenres.isEmpty ? filteredGenres.map({ GenreViewModel(genre: $0) }) : genres.map({ GenreViewModel(genre: $0) })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension GenresViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getNew100(genre: filteredViewModels[indexPath.row].genre)
    }
}

extension GenresViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = StyleConstants.Color.lightGray
        cell.selectionStyle = .none
        cell.textLabel?.font = StyleConstants.Font.body
        cell.textLabel?.text = filteredViewModels[indexPath.row].nameText
        return cell
    }
}
