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
    var person: Person? {
        didSet {
            guard person != nil else {
                return
            }
            castView.viewModel = CastViewModel(person: person!)
        }
    }
    var coordinator: SearchResulting?
    
    override func loadView() {
        view = castView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TextConstants.allCast
        castView.castSelected = { [weak self] cast in
            guard let self = self else { return }
            self.search(query: cast)
        }
    }
    
    func search(query: String) {
        netflixClient.search(query: query) { (response, error) in
                        
            guard let response = response,
                  (response.count != 0) else {
                return
            }

            self.coordinator?.showResult(navigationTitle: query, results: response)
        }
        
    }
    
}
