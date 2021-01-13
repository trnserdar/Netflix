//
//  CastViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 27.12.2020.
//

import UIKit

class CastViewController: UIViewController {

    let castView = CastView()
    var netflixClient: NetflixClientProtocol = NetflixClient()
    var person: Person? {
        didSet {
            guard person != nil else {
                return
            }
            castView.viewModel = CastViewModel(person: person!)
        }
    }
    var searchResults: [SearchResult] = []
    var coordinator: SearchResulting?
    
    override func loadView() {
        view = castView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.allCast
        castView.castSelected = { [weak self] cast in
            self?.search(query: cast)
        }
    }
    
    func search(query: String) {
        castView.baseViewModel.isActivityIndicatorEnabled = true
        netflixClient.search(query: query, genreId: nil) { [weak self] (searchResults, error) in
            defer {
                DispatchQueue.main.async {
                    self?.castView.baseViewModel.isActivityIndicatorEnabled = false
                    self?.coordinator?.showResult(navigationTitle: query, results: self?.searchResults ?? [])
                }
            }
            self?.searchResults = searchResults ?? []
        }
        
    }
    
}
