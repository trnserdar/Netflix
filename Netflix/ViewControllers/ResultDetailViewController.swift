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
    private let operationQueue = OperationQueue()
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .utility)
    var searchResult: SearchResult?
    private var titleDetail: TitleDetail?
    private var episodeResults: [EpisodeResult] = []
    private var selectedGenre: Genre?
    private var genreSearchResults: [SearchResult] = []
    lazy var favoriteManager: FavoriteManagerProtocol = FavoriteManager()
    weak var coordinator: (ResultDetailing & SearchResulting & CastDetailing)?

    override func loadView() {
        view = resultDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = resultDetailView.favoriteBarButtonItem
        listenEvents()
        configureNetworkOperations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteManager.getFavorites()
    }
    
    func listenEvents() {
        resultDetailView.resultCategoryView.genreSelected = { [weak self] genreViewModel in
            guard let self = self else { return }
            self.selectedGenre = genreViewModel.genre
            self.configureNetworkOperationForGenre()
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
            self.resultDetailView.viewModel = self.resultDetailView.viewModel.map({ ResultDetailViewModel(titleDetail: $0.titleDetail, favorites: favorites) })
        }
    }
    
    func configureNetworkOperations() {
        guard searchResult != nil,
           searchResult!.netflixid != nil else {
            return
        }
        
        resultDetailView.baseViewModel.isActivityIndicatorEnabled = true
        operationQueue.underlyingQueue = queue
        operationQueue.addOperation {
            
            self.group.enter()
            self.getTitleDetail()
            
            self.group.wait()
            if self.titleDetail?.nfinfo?.type == "series" {
                self.group.enter()
                self.getEpisodes()
            }
            
            self.group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.navigationItem.title = self.resultDetailView.viewModel?.titleText ?? ""
                self.resultDetailView.baseViewModel.isActivityIndicatorEnabled = false
                if let titleDetail = self.titleDetail {
                    self.resultDetailView.viewModel = ResultDetailViewModel(titleDetail: titleDetail, favorites: self.favoriteManager.favorites)
                }
                self.resultDetailView.resultEpisodeView.episodeResultViewModels = self.episodeResults.enumerated().map({ (index, element) in
                    return EpisodeResultViewModel(episodeResult: element, isSelected: index == 0 ? true : false)
                })
            }
        }
    }
    
    func getTitleDetail() {
        netflixClient.titleDetail(netflixId: searchResult!.netflixid!) { (response, error) in
            defer { self.group.leave() }
            guard let titleDetail = response else {
                return
            }
            
            self.titleDetail = titleDetail
        }
    }
    
    func getEpisodes() {
        netflixClient.episodeDetail(netflixId: searchResult!.netflixid!) { (results, error) in
            defer { self.group.leave() }
            guard let results = results,
                  !results.isEmpty else {
                return
            }
            
            self.episodeResults = results
        }
        
    }
    
    func configureNetworkOperationForGenre() {
        guard let genre = selectedGenre else {
            return
        }
        resultDetailView.baseViewModel.isActivityIndicatorEnabled = true
        queue.async(group: group) {
            self.group.enter()
            self.getNew100(genre: genre)
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.resultDetailView.baseViewModel.isActivityIndicatorEnabled = false
            self.coordinator?.showResult(navigationTitle: self.selectedGenre?.name ?? "", results: self.genreSearchResults)
        }
        
    }
    
    func getNew100(genre: Genre) {
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { (response, error) in
            defer { self.group.leave() }
            guard let response = response,
                  (response.count != 0) else {
                return
            }
            
            self.genreSearchResults = response
        }
        
    }
    
}
