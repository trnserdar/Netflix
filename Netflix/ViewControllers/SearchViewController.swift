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
    weak var coordinator: SearchCoordinator?

    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.search

        searchView.searchButtonTapped = { [weak self] query in
            guard let self = self else { return }
            self.search(query: query)
        }
        
        searchView.resultSelected = { [weak self] searchResultViewModel in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResultViewModel.searchResult)
        }
        
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }

            self.searchView.searchResultViewModels = response.map({ SearchResultViewModel(searchResult: $0) })
        }
        
    }
}
