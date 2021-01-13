//
//  CastViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class CastViewControllerTests: XCTestCase {

    var sut: CastViewController!
    var mockNetflixClient: MockNetflixClient!
    var mockCoordinator: MockCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = CastViewController()
        mockNetflixClient = MockNetflixClient()
        sut.netflixClient = mockNetflixClient
        mockCoordinator = MockCoordinator()
        sut.coordinator = mockCoordinator
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockNetflixClient = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func test_initCast_setCastView() {
        XCTAssertTrue((sut.view as Any) is CastView)
    }
    
    func test_initCast_setNavigationItemTitle() {
        XCTAssertEqual(sut.navigationItem.title, TextConstants.allCast)
    }
    
    func test_personChanged_givenPerson_setViewModel() {
        sut.person = Person(actor: ["Actor"], creator: ["Creator"], director: ["Director"])
        XCTAssertNotNil(sut.castView.viewModel)
    }
    
    func test_personChanged_emptyPerson_setViewModel() {
        sut.person = nil
        XCTAssertNil(sut.castView.viewModel)
    }
    
    func test_castSelected_setActivityIndicator() {
        sut.castView.castSelected?("Andy Samberg")
        XCTAssertTrue(sut.castView.baseViewModel.isActivityIndicatorEnabled)
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
        XCTAssertFalse(sut.castView.baseViewModel.isActivityIndicatorEnabled)
    }

    func test_search_givenSearchResults_whenRequstFinished_setSearchResultingCountt() {
        let expectationSearch = expectation(description: "Search")
        sut.search(query: "Andy Samberg")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationSearch.fulfill()
        }
        mockNetflixClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationSearch], timeout: 1)
        XCTAssertEqual(mockCoordinator.showResultCount, 1)
    }
}
