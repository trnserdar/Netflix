//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searchResultView = SearchResultView()
    var genre: Genre?
    var searchResults: [SearchResult] = [] {
        didSet {
            searchResultView.searchResultViewModels = searchResults.map({ SearchResultViewModel(searchResult: $0) })
        }
    }
    weak var coordinator: ResultDetailing?

    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultView.resultSelected = { [weak self] searchResultViewModel in
            guard let self = self else { return }
            self.coordinator?.showResultDetail(result: searchResultViewModel.searchResult)
        }
    }
    
}
