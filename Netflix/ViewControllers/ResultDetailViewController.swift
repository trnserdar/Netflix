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
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: (ResultDetailing & SearchResulting & CastDetailing)?
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
                
        navigationItem.rightBarButtonItem = resultDetailView.favoriteBarButtonItem
        listenEvents()
        if searchResult != nil,
           searchResult!.netflixid != nil {
            getTitleDetail()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        resultDetailView.resultCategoryView.genreSelected = { [weak self] genreViewModel in
            guard let self = self else { return }
            self.getNew100(genre: genreViewModel.genre)
        }
        
        resultDetailView.resultAllCastView.allCastButtonAction = { [weak self] viewModel in
            guard let self = self else { return }
            guard let cast = viewModel.titleDetail.cast else {
                return
            }
            self.coordinator?.showCastDetail(person: cast)
        }
    
        resultDetailView.favoriteSelected = { [weak self] searchResult in
            guard let self = self else { return }
            self.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            guard let self = self else { return }
            self.viewModel = self.viewModel.map({ ResultDetailViewModel(titleDetail: $0.titleDetail, favorites: favorites) })
        }
    }
    
    func getTitleDetail() {
        netflixClient.titleDetail(netflixId: searchResult!.netflixid!) { (response, error) in
            guard let titleDetail = response else {
                print("Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            self.viewModel = ResultDetailViewModel(titleDetail: titleDetail, favorites: self.favoriteManager.favorites)
        }
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.coordinator?.showResult(navigationTitle: genre.name, results: response)
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
