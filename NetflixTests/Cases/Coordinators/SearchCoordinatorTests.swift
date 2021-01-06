//
//  SearchCoordinatorTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class SearchCoordinatorTests: XCTestCase {

    var sut: SearchCoordinator!
    var navigationController: SpyNavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = SpyNavigationController()
        sut = SearchCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_initSearchCoordinator_conformsToSearchResulting() {
        XCTAssertTrue((sut as Any) is SearchResulting)
    }
    
    func test_initSearchCoordinator_conformsToResultDetailing() {
        XCTAssertTrue((sut as Any) is ResultDetailing)
    }
    
    func test_initSearchCoordinator_conformsToCastDetailing() {
        XCTAssertTrue((sut as Any) is CastDetailing)
    }
    
    func test_searchCoordinator_whenStartCalled_setPushedViewController() {
        sut.start()
        guard navigationController.pushedViewController is SearchViewController else {
            XCTFail()
            return
        }
    }
    
    func test_searchCoordinator_whenStartCalled_setTabBarTitle() {
        sut.start()
        guard let searchVC = navigationController.pushedViewController as? SearchViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchVC.tabBarItem.title, StyleConstants.TabBar.TabBarTitle.search.rawValue)
    }
    
    func test_searchCoordinator_whenStartCalled_setTabBarImage() {
        sut.start()
        guard let searchVC = navigationController.pushedViewController as? SearchViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchVC.tabBarItem.image, UIImage(systemName: StyleConstants.TabBar.TabBarImage.search.rawValue))
    }
    
    func test_searchCoordinator_whenShowResultCalled_setPushedViewController() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard navigationController.pushedViewController is SearchResultViewController else {
            XCTFail()
            return
        }
    }
    
    func test_searchCoordinator_whenShowResultCalled_setCoordinator() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(searchResultVC.coordinator)
    }
    
    func test_searchCoordinator_whenShowResultCalled_whenResultEmpty_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 0)
    }
    
    func test_searchCoordinator_whenShowResultCalled_whenGiven1Result_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [SearchResult.dummy])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 1)
    }
    
    func test_searchCoordinator_whenShowResultCalled_setTitle() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.title, "Test Title")
    }
    
    func test_searchCoordinator_whenShowResultDetailCalled_setPushedViewController() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard navigationController.pushedViewController is ResultDetailViewController else {
            XCTFail()
            return
        }
    }
    
    func test_searchCoordinator_whenShowResultDetailCalled_setCoordinator() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(resultDetailVC.coordinator)
    }

    func test_searchCoordinator_whenShowResultDetailCalled_whenGivenResult_setSearchResult() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(resultDetailVC.searchResult?.title, SearchResult.dummy.title)
    }
    
    func test_searchCoordinator_whenShowCastDetailCalled_setPushedViewController() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard navigationController.pushedViewController is CastViewController else {
            XCTFail()
            return
        }
    }
    
    func test_searchCoordinator_whenShowCastDetailCalled_setCoordinator() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(castDetailVC.coordinator)
    }

    func test_searchCoordinator_whenShowCastDetailCalled_whenGivenPerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 1)
    }
    
    func test_searchCoordinator_whenShowCastDetailCalled_whenGivenMultiplePerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor1", "actor2", "actor3"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 3)
    }

}
