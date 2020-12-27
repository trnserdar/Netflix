//
//  ResultDetailViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class ResultDetailViewController: UIViewController {

    let resultDetailView = ResultDetailView()
    lazy var netflixClient = NetflixClient()
    weak var coordinator: (ResultDetailing & SearchResulting)?

    
    var searchResult: SearchResult?
    var viewModel: ResultDetailViewModel? {
        didSet {
            navigationItem.title = viewModel?.titleText ?? ""
            resultDetailView.viewModel = viewModel
            
            if viewModel != nil,
               viewModel!.episodesIsEnabled {
                self.getEpisodes()
            }
        }
    }
    var episodeResultViewModels: [EpisodeResultViewModel] = [] {
        didSet {
            resultDetailView.resultEpisodeView.episodeResultViewModels = episodeResultViewModels
        }
    }

    override func loadView() {
        view = resultDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        resultDetailView.resultCategoryView.genreSelected = { [weak self] genreViewModel in
            guard let self = self else { return }
            self.getNew100(genre: genreViewModel.genre)
        }
        
        resultDetailView.resultAllCastView.allCastButtonAction = { [weak self] viewModel in
            print("Selected View Model: \(viewModel)")
        }
        
        if searchResult != nil,
           searchResult!.netflixid != nil {
            getTitleDetail()
        }

        // Do any additional setup after loading the view.
    }
    
    func getTitleDetail() {
        netflixClient.titleDetail(netflixId: searchResult!.netflixid!) { (response, error) in
            guard let titleDetail = response else {
                print("Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            self.viewModel = ResultDetailViewModel(titleDetail: titleDetail)
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
    
    func getEpisodes() {
        netflixClient.episodeDetail(netflixId: searchResult!.netflixid!) { (results, error) in
            guard let results = results,
                  !results.isEmpty else {
                return
            }
            
            self.episodeResultViewModels = results.enumerated().map({ (index, element) in
                return EpisodeResultViewModel(episodeResult: element, isSelected: index == 0 ? true : false)
            })
        }
    }
}
