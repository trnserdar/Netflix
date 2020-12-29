//
//  CastViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 27.12.2020.
//

import UIKit

class CastViewController: UIViewController {

    let castView = CastView()
    lazy var netflixClient = NetflixClient()
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .utility)
    var person: Person? {
        didSet {
            guard person != nil else {
                return
            }
            castView.viewModel = CastViewModel(person: person!)
        }
    }
    var query: String?
    var searchResults: [SearchResult] = []
    var coordinator: SearchResulting?
    
    override func loadView() {
        view = castView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.allCast
        castView.castSelected = { [weak self] cast in
            guard let self = self else { return }
            self.query = cast
            self.configureNetworkOperationForSearch()
        }
    }
    
    func configureNetworkOperationForSearch() {
        guard let query = self.query else {
            return
        }
        castView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.search(query: query)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.castView.baseViewModel.isActivityIndicatorEnabled = false
            self.coordinator?.showResult(navigationTitle: query, results: self.searchResults)
        }
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
            defer { self.group.leave() }
            guard let response = response,
                  (response.count != 0) else {
                return
            }

            self.searchResults = response
        }
        
    }
    
}
