//
//  HomeCoordinatorsTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class HomeCoordinatorsTests: XCTestCase {

    var sut: HomeCoordinator!
    var navigationController: SpyNavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = SpyNavigationController()
        sut = HomeCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func test_initHomeCoordinator_conformsToSearchResulting() {
        XCTAssertTrue((sut as Any) is SearchResulting)
    }
    
    func test_initHomeCoordinator_conformsToResultDetailing() {
        XCTAssertTrue((sut as Any) is ResultDetailing)
    }
    
    func test_initHomeCoordinator_conformsToCastDetailing() {
        XCTAssertTrue((sut as Any) is CastDetailing)
    }
    
    func test_homeCoordinator_whenStartCalled_setPushedViewController() {
        sut.start()
        guard navigationController.pushedViewController is HomeViewController else {
            XCTFail()
            return
        }
    }
    
    func test_homeCoordinator_whenStartCalled_setTabBarTitle() {
        sut.start()
        guard let homeVC = navigationController.pushedViewController as? HomeViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(homeVC.tabBarItem.title, StyleConstants.TabBar.TabBarTitle.home.rawValue)
    }
    
    func test_homeCoordinator_whenStartCalled_setTabBarImage() {
        sut.start()
        guard let homeVC = navigationController.pushedViewController as? HomeViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(homeVC.tabBarItem.image, UIImage(systemName: StyleConstants.TabBar.TabBarImage.home.rawValue))
    }
    
    func test_homeCoordinator_whenShowResultCalled_setPushedViewController() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard navigationController.pushedViewController is SearchResultViewController else {
            XCTFail()
            return
        }
    }
    
    func test_homeCoordinator_whenShowResultCalled_setCoordinator() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(searchResultVC.coordinator)
    }
    
    func test_homeCoordinator_whenShowResultCalled_whenResultEmpty_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 0)
    }
    
    func test_homeCoordinator_whenShowResultCalled_whenGiven1Result_setSearchResults() {
        sut.showResult(navigationTitle: "Test Title", results: [SearchResult.dummy])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.searchResults.count, 1)
    }
    
    func test_homeCoordinator_whenShowResultCalled_setTitle() {
        sut.showResult(navigationTitle: "Test Title", results: [])
        guard let searchResultVC = navigationController.pushedViewController as? SearchResultViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(searchResultVC.title, "Test Title")
    }
    
    func test_homeCoordinator_whenShowResultDetailCalled_setPushedViewController() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard navigationController.pushedViewController is ResultDetailViewController else {
            XCTFail()
            return
        }
    }
    
    func test_homeCoordinator_whenShowResultDetailCalled_setCoordinator() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(resultDetailVC.coordinator)
    }

    func test_homeCoordinator_whenShowResultDetailCalled_whenGivenResult_setSearchResult() {
        sut.showResultDetail(result: SearchResult.dummy)
        guard let resultDetailVC = navigationController.pushedViewController as? ResultDetailViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(resultDetailVC.searchResult?.title, SearchResult.dummy.title)
    }
    
    func test_homeCoordinator_whenShowCastDetailCalled_setPushedViewController() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard navigationController.pushedViewController is CastViewController else {
            XCTFail()
            return
        }
    }
    
    func test_homeCoordinator_whenShowCastDetailCalled_setCoordinator() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(castDetailVC.coordinator)
    }

    func test_homeCoordinator_whenShowCastDetailCalled_whenGivenPerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 1)
    }
    
    func test_homeCoordinator_whenShowCastDetailCalled_whenGivenMultiplePerson_setPerson() {
        sut.showCastDetail(person: Person(actor: ["actor1", "actor2", "actor3"], creator: ["creator"], director: ["director"]))
        guard let castDetailVC = navigationController.pushedViewController as? CastViewController else {
            XCTFail()
            return
        }
        XCTAssertEqual(castDetailVC.person?.actor?.count, 3)
    }
    
}
