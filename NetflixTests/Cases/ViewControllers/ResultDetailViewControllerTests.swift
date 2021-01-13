//
//  ResultDetailViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class ResultDetailViewControllerTests: XCTestCase {

    var sut: ResultDetailViewController!
    var mockNetflixClient: MockNetflixClient!
    var mockCoordinator: MockCoordinator!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        super.setUp()
        sut = ResultDetailViewController()
        mockNetflixClient = MockNetflixClient()
        sut.netflixClient = mockNetflixClient
        mockCoordinator = MockCoordinator()
        sut.coordinator = mockCoordinator
        mockFavoriteManager = MockFavoriteManager()
        sut.favoriteManager = mockFavoriteManager
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockNetflixClient = nil
        mockCoordinator = nil
        mockFavoriteManager = nil
        super.tearDown()
    }
    
    func test_initResultDetail_setResultDetailView() {
        XCTAssertTrue((sut.view as Any) is ResultDetailView)
    }
    
    func test_initResultDetail_setRightBarButtonItem() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem, sut.resultDetailView.favoriteBarButtonItem)
    }
    
    func test_listenEvents_whenGenreSelected_setGenre() {
        sut.searchResult = SearchResult.dummy
        sut.resultDetailView.resultCategoryView.genreSelected = { genreViewModel in
            XCTAssertEqual(genreViewModel.genre.name,  "Genre Test")
        }
        sut.resultDetailView.resultCategoryView.genreSelected?(GenreViewModel(genre: Genre(name: "Genre Test", ids: nil)))
    }
    
    func test_listenEvents_whenAllCastButtonTapped_whenGivenTitle_setTitleDetail() {
        sut.resultDetailView.resultAllCastView.allCastButtonAction = { resultDetailViewModel in
            XCTAssertEqual(resultDetailViewModel.titleDetail.nfinfo?.netflixid, TitleDetail.dummy.nfinfo?.netflixid)
        }
        sut.resultDetailView.resultAllCastView.allCastButtonAction?(ResultDetailViewModel(titleDetail: TitleDetail.dummy, favorites: []))
    }
    
    func test_listenEvents_whenAllCastButtonTapped_whenGivenTitleWithoutCast_setShowCastDetailCount() {
        var titleDetail = TitleDetail.dummy
        titleDetail.people = nil
        sut.resultDetailView.resultAllCastView.allCastButtonAction = { resultDetailViewModel in
            XCTAssertEqual(self.mockCoordinator.showCastDetailingCount, 0)
        }
        sut.resultDetailView.resultAllCastView.allCastButtonAction?(ResultDetailViewModel(titleDetail: titleDetail, favorites: []))
    }
    
    func test_listenEvents_whenFavoriteSelected_setSearchResult() {
        sut.resultDetailView.favoriteSelected = { searchResult in
            XCTAssertEqual(searchResult.title, SearchResult.dummy.title)
        }
        sut.resultDetailView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoritesChanged_setViewModel() {
        sut.resultDetailView.viewModel = ResultDetailViewModel(titleDetail: TitleDetail.dummy, favorites: [])
        sut.favoriteManager.favoritesChanged = { favorites in
            XCTAssertEqual(self.sut.resultDetailView.viewModel?.titleDetail.nfinfo?.netflixid, TitleDetail.dummy.nfinfo?.netflixid)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy])
    }
    
    func test_viewWillAppear_setGetFavoritesCount() {
        sut.viewWillAppear(true)
        XCTAssertEqual(mockFavoriteManager.getFavoritesCount, 1)
    }
    
    func test_configureNetworkOperation_whenSearchResultWithoutNetflixId_setActivityIndicator() {
        var searchResult = SearchResult.dummy
        searchResult.netflixid = nil
        sut.searchResult = searchResult
        XCTAssertFalse(sut.resultDetailView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_configureNetworkOperation_whenSearchResult_setActivityIndicator() {
        sut.searchResult = SearchResult.dummy
        sut.configureNetworkOperations()
        XCTAssertTrue(sut.resultDetailView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_getTitleDetail_setTitleDetail() {
        let expectationTitleDetail = expectation(description: "TitleDetail")
        sut.searchResult = SearchResult.dummy
        sut.group.enter()
        sut.getTitleDetail()
        sut.group.notify(queue: .main) {
            expectationTitleDetail.fulfill()
        }
        mockNetflixClient.titleDetailCompletion?(TitleDetail.dummy, nil)
        wait(for: [expectationTitleDetail], timeout: 1.0)
        XCTAssertEqual(sut.titleDetail?.nfinfo?.netflixid, sut.titleDetail?.nfinfo?.netflixid)
    }
    
    func test_getEpisodes_whenGivenEpisodes_setEpisodes() {
        let expectationEpisodes = expectation(description: "Episodes")
        sut.searchResult = SearchResult.dummy
        sut.group.enter()
        sut.getEpisodes()
        sut.group.notify(queue: .main) {
            expectationEpisodes.fulfill()
        }
        mockNetflixClient.episodeDetailCompletion?([EpisodeResult(seasid: "id", seasnum: "num", country: "country", episodes: nil)], nil)
        wait(for: [expectationEpisodes], timeout: 1.0)
        XCTAssertEqual(sut.episodeResults.count, 1)
    }
    
    func test_getEpisodes_emptyEpisode_setEpisodes() {
        let expectationEpisodes = expectation(description: "Episodes")
        sut.searchResult = SearchResult.dummy
        sut.group.enter()
        sut.getEpisodes()
        sut.group.notify(queue: .main) {
            expectationEpisodes.fulfill()
        }
        mockNetflixClient.episodeDetailCompletion?(nil, nil)
        wait(for: [expectationEpisodes], timeout: 1.0)
        XCTAssertEqual(sut.episodeResults.count, 0)
    }
    
    func test_search_givenGenre_setActivityIndicator() {
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: [1]))
        XCTAssertTrue(sut.resultDetailView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_search_givenGenreWithoutId_setActivityIndicator() {
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: nil))
        XCTAssertTrue(sut.resultDetailView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_search_givenGenre_whenGivenSearchResults_setGenreSearchResults() {
        let expectationSearch = expectation(description: "search")
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1.0)
        XCTAssertEqual(sut.genreSearchResults.count, 1)
    }
    
    func test_search_givenGenre_emptySearchResult_setGenreSearchResults() {
        let expectationSearch = expectation(description: "search")
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?(nil, nil)
        wait(for: [expectationSearch], timeout: 1.0)
        XCTAssertEqual(sut.genreSearchResults.count, 0)
    }
    
    func test_search_givenGenre_whenGivenSearchResults_setActivityIndicator() {
        let expectationSearch = expectation(description: "search")
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1.0)
        XCTAssertFalse(sut.resultDetailView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_search_givenGenre_whenGivenSearchResults_setShowResultCount() {
        let expectationSearch = expectation(description: "search")
        sut.searchResult = SearchResult.dummy
        sut.getNew100(genre: Genre(name: "Genre Test", ids: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1.0)
        XCTAssertEqual(mockCoordinator.showResultCount, 1)
    }
}
