//
//  CategoryViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class CategoryViewTests: XCTestCase {

    var sut: CategoryView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromCategoryViewModel()
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
    
    
    func whenSUTSetFromCategoryViewModel(categoryViewModel: CategoryViewModel? = nil) {
        sut = CategoryView(viewModel: categoryViewModel)
    }
    
    func test_initCategory_whenInitCoder() {
        sut = CategoryView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initCategory_setCategoryButton() {
        XCTAssertTrue(sut.subviews.contains(sut.categoryButton))
    }
    
    func test_initCategory_setCategoryLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.categoryLabel))
    }
    
    func test_initCategory_setSearchResultView() {
        XCTAssertTrue(sut.subviews.contains(sut.searchResultView))
    }
    
    func test_categoryLabelAppearance_setFont() {
        XCTAssertEqual(sut.categoryLabel.font, StyleConstants.Font.headline)
    }
    
    func test_categoryLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.categoryLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_categoryLabelAppearance_whenViewModelEmpty_setText() {
        XCTAssertEqual(sut.categoryLabel.text, "")
    }
    
    func test_categoryLabelAppearance_whenGivenViewModel_setText() {
        whenSUTSetFromCategoryViewModel(categoryViewModel: CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: []))
        XCTAssertEqual(sut.categoryLabel.text, "Test Category")
    }
    
    func test_categoryButtonAppearance_setTitleFont() {
        XCTAssertEqual(sut.categoryButton.titleLabel?.font, StyleConstants.Font.headline)
    }
    
    func test_categoryButtonAppearance_setTitleTextAlignment() {
        XCTAssertEqual(sut.categoryButton.titleLabel?.textAlignment, .right)
    }
    
    func test_categoryButtonAppearance_setTitleColor() {
        XCTAssertEqual(sut.categoryButton.titleLabel?.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_categoryButtonAppearance_setTitleText() {
        XCTAssertEqual(sut.categoryButton.titleLabel?.text, TextConstants.showAll)
    }
    
    func test_categoryButtonTapped_whenGivenViewModel() {
        whenSUTSetFromCategoryViewModel(categoryViewModel: CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: []))
        sut.showAllTapped = { results in
            XCTAssertEqual(results.count, 1)
        }
        sut.categoryButtonTapped()
    }
    
    func test_categoryButtonTapped_whenViewModelEmpty() {
        sut.showAllTapped = { results in
            XCTAssertTrue(results.isEmpty)
        }
        sut.categoryButtonTapped()
    }
    
    func test_viewModelDidChange_whenViewModelEmpty_setViewModel() {
        whenSUTSetFromCategoryViewModel(categoryViewModel: CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: []))
        sut.viewModel = nil
        XCTAssertEqual(sut.categoryLabel.text, "Test Category")
    }
    
    func test_viewModelDidChange_givenViewModel_setCategoryLabel() {
        sut.viewModel = CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: [])
        XCTAssertEqual(sut.categoryLabel.text, "Test Category")
    }
    
    func test_viewModelDidChange_givenViewModel_setViewModels() {
        sut.viewModel = CategoryViewModel(categoryName: "Test Category", searchResults: [whenSetSearchResult()], favorites: [])
        XCTAssertEqual(sut.searchResultView.viewModels.count, 1)
    }
}
