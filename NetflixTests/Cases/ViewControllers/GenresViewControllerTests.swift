//
//  GenresViewControllerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 10.01.2021.
//

import XCTest
@testable import Netflix

class GenresViewControllerTests: XCTestCase {

    var sut: GenresViewController!
    var mockNetworkClient: MockNetflixClient!
    var mockCoordinator: MockCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = GenresViewController()
        mockNetworkClient = MockNetflixClient()
        sut.netflixClient = mockNetworkClient
        mockCoordinator = MockCoordinator()
        sut.coordinator = mockCoordinator
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        sut = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func test_initGenres_setGenresView() {
        XCTAssertTrue((sut.view as Any) is GenresView)
    }
    
    func test_initGenres_setNavigationItemTitle() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, TextConstants.genres)
    }
    
    func test_listenEvents_searchBarTextDidChange_whenGivenGenre_setViewModels() {
        sut.listenEvents()
        sut.genres = [Genre(name: "Genre Text", ids: nil)]
        sut.genresView.searchBarTextDidChange?("Genre")
        XCTAssertEqual(sut.genresView.filteredViewModels.count, 1)
    }
    
    func test_listenEvents_searchBarTextDidChange_whenGivenNotContainsGenres_setViewModels() {
        sut.listenEvents()
        sut.genres = [Genre(name: "Genre", ids: nil), Genre(name: "Genre 2", ids: nil)]
        sut.genresView.searchBarTextDidChange?("Search")
        XCTAssertEqual(sut.genresView.filteredViewModels.count, 2)
    }
    
    func test_listenEvents_searchBarTextDidChange_whenEmptyGenres_setViewModels() {
        sut.listenEvents()
        sut.genresView.searchBarTextDidChange?("Search")
        XCTAssertEqual(sut.genresView.filteredViewModels.count, 0)
    }
    
    func test_listenEvents_genreSelected_setActivityIndicator() {
        sut.listenEvents()
        sut.genresView.genreSelected?(Genre(name: "Genre Test", ids: nil))
        XCTAssertTrue(sut.genresView.baseViewModel.isActivityIndicatorEnabled)
    }

    func test_getGenres_whenGivenGenre_whenRequestStart_setActivityIndicator() {
        sut.getGenres()
        XCTAssertEqual(sut.genresView.baseViewModel.isActivityIndicatorEnabled, true)
    }
    
    func test_getGenres_whenGivenGenre_whenRequestFinished_setGenresCount() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([Genre(name: "Genre 1", ids: nil)] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(sut.genres.count, 1)
    }
    
    func test_getGenres_whenGivenGenre_whenRequestFinished_setGenres() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([Genre(name: "Genre 1", ids: nil)] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(mockNetworkClient.genresCount, 1)
    }
    
    func test_getGenres_whenEmptyGenres_whenRequestFinished_setGenres() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(sut.genres.count, 0)
    }
    
    func test_getGenres_whenGivenGenre_whenRequestFinished_setActivitiyIndicator() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([Genre(name: "Genre 1", ids: nil)] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertFalse(sut.genresView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_getGenres_whenGivenGenre_whenRequestFinished_setViewModels() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([Genre(name: "Genre 1", ids: nil)] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(sut.genresView.filteredViewModels.count, 1)
    }
    
    func test_getGenres_whenGivenGenre_whenRequestFinished_setThread() {
        let expectationGenres = expectation(description: "Genres")
        sut.getGenres()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.genresCompletion?([Genre(name: "Genre 1", ids: nil)] , nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(Thread.isMainThread, true)
    }
    
    func test_getResultsWithSelectedGenre_whenGivenSearchResults_whenRequestStarted_setActivityIndicator() {
        sut.getNew100(genre: Genre(name: "Genre", ids: [1]))
        XCTAssertTrue(sut.genresView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_getResultsWithSelectedGenre_whenGivenSearchResults_whenRequestFinished_setActivityIndicator() {
        let expectationGenres = expectation(description: "Genres")
        sut.getNew100(genre: Genre(name: "Genre", ids: [1]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertFalse(sut.genresView.baseViewModel.isActivityIndicatorEnabled)
    }
    
    func test_getResultsWithSelectedGenre_whenGivenSearchResults_whenRequestFinished_setSearchResults() {
        let expectationGenres = expectation(description: "Genres")
        sut.getNew100(genre: Genre(name: "Genre", ids: [1]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.searchCompletion?([SearchResult.dummy, SearchResult.dummy], nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(sut.searchResults.count, 2)
    }
    
    func test_getResultsWithSelectedGenre_whenEmptySearchResult_whenRequestFinished_setSearchResults() {
        let expectationGenres = expectation(description: "Genres")
        sut.getNew100(genre: Genre(name: "Genre", ids: [1]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.searchCompletion?([], nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func test_getResultsWithSelectedGenre_whenEmptySearchResult_whenRequestFinished_setShowResultCount() {
        let expectationGenres = expectation(description: "Genres")
        sut.getNew100(genre: Genre(name: "Genre", ids: [1]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectationGenres.fulfill()
        }
        mockNetworkClient.searchCompletion?([], nil)
        wait(for: [expectationGenres], timeout: 1)
        XCTAssertEqual(mockCoordinator.showResultCount, 1)
    }
    
}
