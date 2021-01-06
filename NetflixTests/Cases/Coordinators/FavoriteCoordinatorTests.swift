//
//  FavoriteCoordinatorTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class FavoriteCoordinatorTests: XCTestCase {

    var sut: FavoriteCoordinator!
    var navigationController: SpyNavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = SpyNavigationController()
        sut = FavoriteCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_initFavoriteCoordinator_conformsToSearchResulting() {
        XCTAssertTrue((sut as Any) is SearchResulting)
    }
    
    func test_initFavoriteCoordinator_conformsToResultDetailing() {
        XCTAssertTrue((sut as Any) is ResultDetailing)
    }
    
    func test_initFavoriteCoordinator_conformsToCastDetailing() {
        XCTAssertTrue((sut as Any) is CastDetailing)
    }
    
    func test_favoriteCoordinator_whenStartCalled_setPushedViewController() {
        sut.start()
        guard navigationController.pushedViewController is FavoritesViewController else {
            XCTFail()
            return
        }
    }
    
    func test_favoriteCoordinator_whenStartCalled_setTabBarTitle() {
        sut.start()
        guard let favoritesVC = navigationController.pushedViewController as? FavoritesViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(favoritesVC.tabBarItem.title, StyleConstants.TabBar.TabBarTitle.favorite.rawValue)
    }
    
    func test_favoriteCoordinator_whenStartCalled_setTabBarImage() {
        sut.start()
        guard let favoritesVC = navigationController.pushedViewController as? FavoritesViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(favoritesVC.tabBarItem.image, UIImage(systemName: StyleConstants.TabBar.TabBarImage.favorite.rawValue))
    }
    
    func test_favoriteCoordinator_whenShowResultCalled_setPushedViewController() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard navigationController.pushedViewController is SearchResultViewController else {
            XCTFail()
            return
        }
    }
    
    func test_favoriteCoordinator_whenShowResultCalled_setCoordinator() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(searchResultVC.coordinator)
    }
    
    func test_favoriteCoordinator_whenShowResultCalled_whenResultEmpty_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 0)
    }
    
    func test_favoriteCoordinator_whenShowResultCalled_whenGiven1Result_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [SearchResult.dummy])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 1)
    }
    
    func test_favoriteCoordinator_whenShowResultCalled_setTitle() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.title, "Test Title")
    }
    
    func test_favoriteCoordinator_whenShowResultDetailCalled_setPushedViewController() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard navigationController.pushedViewController is ResultDetailViewController else {
            XCTFail()
            return
        }
    }
    
    func test_favoriteCoordinator_whenShowResultDetailCalled_setCoordinator() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(resultDetailVC.coordinator)
    }

    func test_favoriteCoordinator_whenShowResultDetailCalled_whenGivenResult_setSearchResult() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(resultDetailVC.searchResult?.title, SearchResult.dummy.title)
    }
    
    func test_favoriteCoordinator_whenShowCastDetailCalled_setPushedViewController() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard navigationController.pushedViewController is CastViewController else {
            XCTFail()
            return
        }
    }
    
    func test_favoriteCoordinator_whenShowCastDetailCalled_setCoordinator() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(castDetailVC.coordinator)
    }

    func test_favoriteCoordinator_whenShowCastDetailCalled_whenGivenPerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 1)
    }
    
    func test_favoriteCoordinator_whenShowCastDetailCalled_whenGivenMultiplePerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor1", "actor2", "actor3"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 3)
    }

}
