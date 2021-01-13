//
//  ResultDetailViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class ResultDetailViewController: UIViewController {

    let resultDetailView = ResultDetailView()
    lazy var netflixClient: NetflixClientProtocol = NetflixClient()
    let operationQueue = OperationQueue()
    let group = DispatchGroup()
    let queue = DispatchQueue.global(qos: .utility)
    var searchResult: SearchResult?
    private(set) var titleDetail: TitleDetail?
    private(set) var episodeResults: [EpisodeResult] = []
    private(set) var genreSearchResults: [SearchResult] = []
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
            self?.getNew100(genre: genreViewModel.genre)
        }
        
        resultDetailView.resultAllCastView.allCastButtonAction = { [weak self] viewModel in
            guard let cast = viewModel.titleDetail.cast,
                  (cast.actor != nil || cast.creator != nil || cast.director != nil) else {
                return
            }
            self?.coordinator?.showCastDetail(person: cast)
        }
    
        resultDetailView.favoriteSelected = { [weak self] searchResult in
            self?.favoriteManager.favoriteAction(result: searchResult)
        }
        
        favoriteManager.favoritesChanged = { [weak self] favorites in
            self?.resultDetailView.viewModel = self?.resultDetailView.viewModel.map({ ResultDetailViewModel(titleDetail: $0.titleDetail, favorites: favorites) })
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
                self?.navigationItem.title = self?.resultDetailView.viewModel?.titleText ?? ""
                self?.resultDetailView.baseViewModel.isActivityIndicatorEnabled = false
                if let titleDetail = self?.titleDetail {
                    self?.resultDetailView.viewModel = ResultDetailViewModel(titleDetail: titleDetail, favorites: self?.favoriteManager.favorites ?? [])
                }
                self?.resultDetailView.resultEpisodeView.episodeResultViewModels = self?.episodeResults.enumerated().map({ (index, element) in
                    return EpisodeResultViewModel(episodeResult: element, isSelected: index == 0 ? true : false)
                }) ?? []
            }
        }
    }
    
    func getTitleDetail() {
        netflixClient.titleDetail(netflixId: searchResult!.netflixid!) { (response, error) in
            defer { self.group.leave() }
            self.titleDetail = response
        }
    }
    
    func getEpisodes() {
        netflixClient.episodeDetail(netflixId: searchResult!.netflixid!) { (results, error) in
            defer { self.group.leave() }
            self.episodeResults = results ?? []
        }
        
    }
    
    func getNew100(genre: Genre) {
        resultDetailView.baseViewModel.isActivityIndicatorEnabled = true
        netflixClient.search(query: "get:new100", genreId: "\(genre.ids?.first ?? 0)") { [weak self] (response, error) in
            defer {
                DispatchQueue.main.async {
                    self?.resultDetailView.baseViewModel.isActivityIndicatorEnabled = false
                    self?.coordinator?.showResult(navigationTitle: genre.name, results: self?.genreSearchResults ?? [])
                }
            }
            self?.genreSearchResults = response ?? []
        }
        
    }
    
}
