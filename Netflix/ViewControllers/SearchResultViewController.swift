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
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = genre?.name ?? ""
    }
    
}
