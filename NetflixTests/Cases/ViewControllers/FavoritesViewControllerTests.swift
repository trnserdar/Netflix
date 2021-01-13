//
//  FavoritesViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class FavoritesViewControllerTests: XCTestCase {

    var sut: FavoritesViewController!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        super.setUp()
        sut = FavoritesViewController()
        mockFavoriteManager = MockFavoriteManager()
        sut.favoriteManager = mockFavoriteManager
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockFavoriteManager = nil
        super.tearDown()
    }
    
    func test_initFavorites_setFavoriteView() {
        XCTAssertTrue((sut.view as Any) is SearchResultView)
    }
    
    func test_initFavorites_setNavigationItemTitle() {
        XCTAssertEqual(sut.navigationItem.title, TextConstants.favorites)
    }
    
    func test_viewWillAppear_setGetFavoritesCount() {
        sut.viewWillAppear(true)
        XCTAssertEqual(mockFavoriteManager.getFavoritesCount, 1)
    }
    
    func test_listenEvents_whenResultSelected_setResult() {
        sut.favoriteView.resultSelected = { result in
            XCTAssertEqual(result.title, SearchResult.dummy.title)
        }
        sut.favoriteView.resultSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteSelected_setResult() {
        sut.favoriteView.favoriteSelected = {  result in
            XCTAssertEqual(result.title, SearchResult.dummy.title)
        }
        sut.favoriteView.favoriteSelected?(SearchResult.dummy)
    }
    
    func test_listenEvents_whenFavoriteChanged_setViewModels() {
        sut.favoriteView.viewModels = [SearchResultViewModel(searchResult: SearchResult.dummy, favorites: [])]
        sut.favoriteManager.favoritesChanged = { favorites in
            XCTAssertEqual(self.sut.favoriteView.viewModels.count, 1)
        }
        sut.favoriteManager.favoritesChanged?([TitleDetail.dummy])
    }
    
    

}
