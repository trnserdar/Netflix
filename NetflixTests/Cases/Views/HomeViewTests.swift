//
//  HomeViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class HomeViewTests: XCTestCase {
    
    var sut: HomeView!
    override func setUp() {
        super.setUp()
        sut = HomeView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetSearchResult(netflixid: String? = "81393502",
                                    title: String? = "title",
                                    image: String? = "https://image",
                                    synopsis: String? = "synopsis",
                                    rating: String? = "9.9",
                                    type: String? = "movie",
                                    released: String? = "2020",
                                    runtime: String? = "59m",
                                    largeimage: String? = "https://largeImage",
                                    imdbid: String? = "123456",
                                    download: String? = "0",
                                    image1: String? = "https://image1",
                                    matlevel: String? = nil,
                                    matlabel: String? = nil,
                                    avgrating: String? = nil,
                                    updated: String? = nil,
                                    unogsdate: String? = nil,
                                    image2: String? = "https://image2") -> SearchResult {
        
        return SearchResult(netflixid: netflixid,
                                        title: title,
                                        image: image,
                                        synopsis: synopsis,
                                        rating: rating,
                                        type: type,
                                        released: released,
                                        runtime: runtime,
                                        largeimage: largeimage,
                                        unogsdate: unogsdate,
                                        imdbid: imdbid,
                                        download: download,
                                        image1: image1,
                                        matlevel: matlevel,
                                        matlabel: matlabel,
                                        avgrating: avgrating,
                                        updated: updated,
                                        image2: image2)
    }

    func test_initHome_whenInitCoder() {
        sut = HomeView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initHome_conformsToBaseView() {
        XCTAssertTrue((sut as Any) is BaseView)
    }
    
    func test_initHome_setScrollView() {
        XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    }
    
    func test_initHome_setStackView() {
        XCTAssertTrue(sut.scrollView.subviews.contains(sut.stackView))
    }
    
    func test_initHome_setNewReleaseView() {
        XCTAssertTrue(sut.stackView.subviews.contains(sut.newReleaseView))
    }
    
    func test_initHome_setActionView() {
        XCTAssertTrue(sut.stackView.subviews.contains(sut.actionView))
    }
    
    func test_scrollViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.scrollView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_scrollViewAppearance_setIsScrollEnabled() {
        XCTAssertTrue(sut.scrollView.isScrollEnabled)
    }
    
    func test_stackViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.stackView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_stackViewAppearance_setAxis() {
        XCTAssertEqual(sut.stackView.axis, .vertical)
    }
    
    func test_stackViewAppearance_setAligment() {
        XCTAssertEqual(sut.stackView.alignment, .fill)
    }
    
    func test_stackViewAppearance_setDistribution() {
        XCTAssertEqual(sut.stackView.distribution, .fill)
    }
    
    func test_stackViewAppearance_setSpacing() {
        XCTAssertEqual(sut.stackView.spacing, 0.0)
    }
    
    func test_viewModelDidChange_setNewReleaseViewModel() {
        sut.viewModel.newRelease = CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: [])
        XCTAssertEqual(sut.newReleaseView.viewModel?.categoryName, "Test Category")
    }
    
}
