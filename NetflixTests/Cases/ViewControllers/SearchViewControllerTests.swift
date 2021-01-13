//
//  SearchViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class SearchViewControllerTests: XCTestCase {

    var sut: SearchViewController!
    var mockNetflixClient: MockNetflixClient!
    var mockCoordinator: MockCoordinator!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        super.setUp()
        sut = SearchViewController()
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
    
    func test_initSearch_setSearchView() {
        XCTAssertTrue((sut.view as Any) is SearchView)
    }
    
    func test_initSearch_setNavigationItemTitle() {
        XCTAssertEqual(sut.navigationItem.title, TextConstants.search)
    }
    
    func test_viewWillAppear_setGetFavoritesCount() {
        sut.viewWillAppear(true)
        XCTAssertEqual(mockFavoriteManager.getFavoritesCount, 1)
    }
    
    func test_listenEvents_whenSearchButtonTapped_setActivitiyIndicator() {
        sut.searchView.searchButtonTapped?("Andy Samberg")
        XCTAssertTrue(sut.searchView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_listenEvents_whenResultSelected_setResultDetailCount() {
        sut.searchView.resultSelected?(SearchResult.dummy)
        XCTAssertEqual(mockCoordinator.showResultDetailCount, 1)
    }
    
    func test_listenEvents_whenFavoriteSelected_setResult() {
        sut.searchView.favoriteSelected = { result in
            XCTAssertEqual(result.title, SearchResult.dummy.title)
        }
        sut.searchView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteChanged_setViewModels() {
        sut.searchView.viewModels = [SearchResultViewModel(searchResult: SearchResult.dummy, favorites: []), SearchResultViewModel(searchResult: SearchResult.dummy, favorites: [])]
        sut.favoriteManager.favoritesChanged = { favorites in
            XCTAssertEqual(self.sut.searchView.viewModels.count, 2)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy, TitleDetail.dummy])
    }
    
    func test_search_given2SearchResults_whenRequstFinished_setSearchResults() {
        let expectationSearch = expectation(description: "Search")
        sut.search(query: "Andy Samberg")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1)
        XCTAssertEqual(sut.searchResults.count, 2)
    }
    
    func test_search_whenEmptySearchResult_whenRequstFinished_setSearchResults() {
        let expectationSearch = expectation(description: "Search")
        sut.search(query: "Andy Samberg")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?(nil, nil)
        wait(for: [expectationSearch], timeout: 1)
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func test_search_givenSearchResults_whenRequstFinished_setActivityIndicator() {
        let expectationSearch = expectation(description: "Search")
        sut.search(query: "Andy Samberg")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1)
        XCTAssertFalse(sut.searchView.baseViewModel.isActivityIndicatorEnabled)
    }

    func test_search_givenSearchResults_whenRequstFinished_setViewModels() {
        let expectationSearch = expectation(description: "Search")
        sut.search(query: "Andy Samberg")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1)
        XCTAssertEqual(sut.searchView.viewModels.count, 2)
    }

}
