//
//  SearchResultViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class SearchResultViewControllerTests: XCTestCase {

    var sut: SearchResultViewController!
    var mockCoordinator: MockCoordinator!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        super.setUp()
        sut = SearchResultViewController()
        mockCoordinator = MockCoordinator()
        sut.coordinator = mockCoordinator
        mockFavoriteManager = MockFavoriteManager()
        sut.favoriteManager = mockFavoriteManager
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockCoordinator = nil
        mockFavoriteManager = nil
        super.tearDown()
    }
    
    func test_initSearchResult_setSearchResultView() {
        XCTAssertTrue((sut.view as Any) is SearchResultView)
    }
    
    func test_viewWillAppear_setGetFavoriteCount() {
        sut.viewWillAppear(true)
        XCTAssertEqual(mockFavoriteManager.getFavoritesCount, 1)
    }
    
    func test_searchResult_whenChanged_setViewModels() {
        sut.searchResults = [SearchResult.dummy, SearchResult.dummy]
        XCTAssertEqual(sut.searchResultView.viewModels.count, 2)
    }
    
    func test_listenEvents_whenResultSelected_setSearchResult() {
        sut.searchResultView.resultSelected = { searchResult in
            XCTAssertEqual(searchResult.title, SearchResult.dummy.title)
        }
        sut.searchResultView.resultSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteSelected_setSearchResult() {
        sut.searchResultView.favoriteSelected = { searchResult in
            XCTAssertEqual(searchResult.title, SearchResult.dummy.title)
        }
        sut.searchResultView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoritesChanged_setViewModels() {
        sut.searchResultView.viewModels = [SearchResultViewModel(searchResult: SearchResult.dummy, favorites: [])]
        sut.favoriteManager.favoritesChanged = { favorites in
            XCTAssertEqual(self.sut.searchResultView.viewModels.count, 1)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy])
    }

}
