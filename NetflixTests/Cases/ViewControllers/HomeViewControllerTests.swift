//
//  HomeViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class HomeViewControllerTests: XCTestCase {

    var sut: HomeViewController!
    var mockNetflixClient: MockNetflixClient!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
        mockNetflixClient = MockNetflixClient()
        sut.netflixClient = mockNetflixClient
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockNetflixClient = nil
        super.tearDown()
    }
    
    func test_initHome_setHomeView() {
        XCTAssertTrue((sut.view as Any) is HomeView)
    }
    
    func test_listenEvents_newReleaseView_whenShowAllTapped_whenSearchResultsEmpty_setResults() {
        sut.listenEvents()
        sut.homeView.newReleaseView.showAllTapped = { results in
            XCTAssertEqual(results.count, 0)
        }
        sut.homeView.newReleaseView.showAllTapped?([])
    }
    
    func test_listenEvents_newReleaseView_whenShowAllTapped_whenGiven1SearchResult_setResults() {
        sut.listenEvents()
        sut.homeView.newReleaseView.showAllTapped = { results in
            XCTAssertEqual(results.count, 1)
        }
        sut.homeView.newReleaseView.showAllTapped?([SearchResult.dummy])
    }
    
    func test_listenEvents_newReleaseView_whenShowAllTapped_whenGiven2SearchResults_setShowResultCount() {
        sut.listenEvents()
        sut.homeView.newReleaseView.showAllTapped = { results in
            XCTAssertEqual(results.count, 2)
        }
        sut.homeView.newReleaseView.showAllTapped?([SearchResult.dummy, SearchResult.dummy])
    }
    
    func test_listenEvents_newReleaseView_whenShowAllTapped_setWeakReference() {
        sut.listenEvents()
        sut.homeView.newReleaseView.showAllTapped = { [weak sut] results in
            XCTAssertNotNil(sut)
        }
        sut.homeView.newReleaseView.showAllTapped?([SearchResult.dummy, SearchResult.dummy])
    }

    func test_listenEvents_actionView_whenShowAllTapped_whenSearchResultsEmpty_setResults() {
        sut.listenEvents()
        sut.homeView.actionView.showAllTapped = { results in
            XCTAssertEqual(results.count, 0)
        }
        sut.homeView.actionView.showAllTapped?([])
    }
    
    func test_listenEvents_actionView_whenShowAllTapped_whenGiven1SearchResult_setResults() {
        sut.listenEvents()
        sut.homeView.actionView.showAllTapped = { results in
            XCTAssertEqual(results.count, 1)
        }
        sut.homeView.actionView.showAllTapped?([SearchResult.dummy])
    }
    
    func test_listenEvents_actionView_whenShowAllTapped_whenGiven2SearchResults_setResults() {
        sut.listenEvents()
        sut.homeView.actionView.showAllTapped = { results in
            XCTAssertEqual(results.count, 2)
        }
        sut.homeView.actionView.showAllTapped?([SearchResult.dummy, SearchResult.dummy])
    }
    
    func test_listenEvents_actionView_whenShowAllTapped_setWeakReference() {
        sut.listenEvents()
        sut.homeView.actionView.showAllTapped = { [weak sut] results in
            XCTAssertNotNil(sut)
        }
        sut.homeView.actionView.showAllTapped?([SearchResult.dummy, SearchResult.dummy])
    }
    
    func test_listenEvents_whenResultSelected_setResult() {
        sut.listenEvents()
        sut.homeView.resultSelected = { result in
            XCTAssertEqual(result.title, SearchResult.dummy.title)
        }
        sut.homeView.resultSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenResultSelected_setWeakReference() {
        sut.listenEvents()
        sut.homeView.resultSelected = { [weak sut] result in
            XCTAssertNotNil(sut)
        }
        sut.homeView.resultSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteSelected_setResult() {
        sut.listenEvents()
        sut.homeView.favoriteSelected = { result in
            XCTAssertEqual(result.title, SearchResult.dummy.title)
        }
        sut.homeView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteSelected_setWeakReference() {
        sut.listenEvents()
        sut.homeView.favoriteSelected = { [weak sut] result in
            XCTAssertNotNil(sut)
        }
        sut.homeView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteChanged_setFavorites() {
        sut.listenEvents()
        sut.favoriteManager.favoritesChanged = { favorites in
            XCTAssertEqual(favorites.count, 2)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy, TitleDetail.dummy])
    }
    
    func test_listenEvents_whenFavoriteChanged_setWeakReference() {
        sut.listenEvents()
        sut.favoriteManager.favoritesChanged = { [weak sut] favorites in
            XCTAssertNotNil(sut)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy, TitleDetail.dummy])
    }
    
    func test_getNewReleases_whenGiven2SearchResults_setNewReleases() {
        let expectationNewReleases = expectation(description: "newReleases")
        sut.group.enter()
        sut.getNewReleases()
        sut.group.notify(queue: .main) {
            expectationNewReleases.fulfill()
        }
        mockNetflixClient.newReleasesCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationNewReleases], timeout: 3.0)
        XCTAssertEqual(sut.newReleases.count, 2)
    }
    
    func test_getNewReleases_whenEmptySearchResult_setNewReleases() {
        let expectationNewReleases = expectation(description: "newReleases")
        sut.group.enter()
        sut.getNewReleases()
        sut.group.notify(queue: .main) {
            expectationNewReleases.fulfill()
        }
        mockNetflixClient.newReleasesCompletion?([], nil)
        wait(for: [expectationNewReleases], timeout: 3.0)
        XCTAssertEqual(sut.newReleases.count, 0)
    }
    
    func test_getNew100_whenGiven2SearchResults_setActions() {
        let expectationActions = expectation(description: "actions")
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: [1]))
        sut.group.notify(queue: .main) {
            expectationActions.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationActions], timeout: 3.0)
        XCTAssertEqual(sut.actions.count, 2)
    }
    
    func test_getNew100_whenEmptySearchResult_setActions() {
        let expectationActions = expectation(description: "actions")
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: [1]))
        sut.group.notify(queue: .main) {
            expectationActions.fulfill()
        }
        mockNetflixClient.searchCompletion?([], nil)
        wait(for: [expectationActions], timeout: 3.0)
        XCTAssertEqual(sut.actions.count, 0)
    }
    
    func test_getNew100_whenGiven1SearchResult_whenGenreIdsEmpty_setActions() {
        let expectationActions = expectation(description: "actions")
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: nil))
        sut.group.notify(queue: .main) {
            expectationActions.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy], nil)
        wait(for: [expectationActions], timeout: 3.0)
        XCTAssertEqual(sut.actions.count, 1)
    }
    
    func test_configureOperations_whenOperationStarted_setActivityIndicator() {
        sut.configureNetworkOperations()
        XCTAssertTrue(sut.homeView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_configureOperations_whenOperationFinished_whenGiven2SearchResult_setNewReleases() {
        let expectationOperations = expectation(description: "operations")
        sut.group.enter()
        sut.getNewReleases()
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: [1]))
        sut.group.notify(queue: .main) {
            expectationOperations.fulfill()
        }
        mockNetflixClient.newReleasesCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        mockNetflixClient.searchCompletion?([SearchResult.dummy], nil)
        wait(for: [expectationOperations], timeout: 3.0)
        XCTAssertEqual(sut.newReleases.count, 2)
    }
    
    func test_configureOperations_whenOperationFinished_whenGiven3SearchResults_setActions() {
        let expectationOperations = expectation(description: "operations")
        sut.group.enter()
        sut.getNewReleases()
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: [1]))
        sut.group.notify(queue: .main) {
            expectationOperations.fulfill()
        }
        mockNetflixClient.newReleasesCompletion?([SearchResult.dummy], nil)
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationOperations], timeout: 3.0)
        XCTAssertEqual(sut.actions.count, 3)
    }
    
    func test_configureOperations_whenOperationFinished_setActivityIndicator() {
        let expectationOperations = expectation(description: "operations")
        sut.group.enter()
        sut.getNewReleases()
        sut.group.enter()
        sut.getNew100(genre: Genre(name: "Test", ids: [1]))
        sut.group.notify(queue: .main) {
            expectationOperations.fulfill()
        }
        mockNetflixClient.newReleasesCompletion?([SearchResult.dummy], nil)
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationOperations], timeout: 3.0)
        XCTAssertEqual(sut.homeView.baseViewModel.isActivityIndicatorEnabled, false)
    }

}
