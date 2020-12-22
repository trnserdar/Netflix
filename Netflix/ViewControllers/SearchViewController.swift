//
//  SearchViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    lazy var netflixClient = NetflixClient()
    var searchResults: [SearchResult] = [] {
        didSet {
            searchResultViewModels = searchResults.map({ SearchResultViewModel(searchResult: $0) })
        }
    }
    var searchResultViewModels: [SearchResultViewModel] = [] {
        didSet {
            searchView.collectionView.reloadData()
        }
    }
    
    weak var coordinator: SearchCoordinator?

    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.search
        
        configureDelegates()
    }
    
    func configureDelegates() {
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.searchBar.delegate = self
        
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }

            self.searchResults = response
        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        guard let query = searchBar.text,
              query != "" else {
            return
        }
        
        search(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SearchViewController selected: \(searchResults[indexPath.row])")
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.configureCell(viewModel: searchResultViewModels[indexPath.row])
        return cell
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: searchResultViewModels[indexPath.row].itemWidth, height: searchResultViewModels[indexPath.row].itemHeight)
    }
}
