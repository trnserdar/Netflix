//
//  GenresViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class GenresViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = StyleConstants.Color.lightGray
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = StyleConstants.Color.lightGray
        searchBar.isTranslucent = true
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = TextConstants.searchPlaceholder
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        return searchBar
    }()

    lazy var netflixClient = NetflixClient()
    private(set) var genres: [Genre] = [] {
        didSet {
            self.filteredViewModels = genres.filter({ !$0.name.contains("All") }).map({ GenreViewModel(genre: $0) })
        }
    }
    private(set) var filteredViewModels: [GenreViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = TextConstants.genres
        getGenres()
    }
    
    override func viewWillLayoutSubviews() {
        configureSearchBar()
        configureTableView()
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
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
    
    func getNew100(genreId: String) {
        
        netflixClient.search(query: "get:new100", genreId: genreId) { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.goSearchResultVC(results: response)
        }
    }
    
    func goSearchResultVC(results: [SearchResult]) {
        
        let searchResultViewController = SearchResultViewController()
        searchResultViewController.searchResults = results
        self.navigationController?.pushViewController(searchResultViewController, animated: true)
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
        getNew100(genreId: filteredViewModels[indexPath.row].selectedId)
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
