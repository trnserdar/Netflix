//
//  SearchResultViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class SearchResultViewTests: XCTestCase {

    var sut: SearchResultView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromScrollDirection()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetSearchResultViewModel(netflixid: String? = "81393502",
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
                                    image2: String? = "https://image2",
                                    sizeOption: SizeOption = .small,
                                    favorites: [TitleDetail] = [TitleDetail.dummy]) -> SearchResultViewModel {
        
        let searchResult = SearchResult(netflixid: netflixid,
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
        return SearchResultViewModel(searchResult: searchResult, sizeOption: sizeOption, favorites: favorites)
    }
    
    func whenSUTSetFromScrollDirection(scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        sut = SearchResultView(scrollDirection: scrollDirection)
    }
    
    func test_initSearchResult_setScrollDirection() {
        XCTAssertEqual(sut.scrollDirection, .vertical)
    }
    
    func test_initSearchResult_whenGivenHorizontal_setScrollDirection() {
        whenSUTSetFromScrollDirection(scrollDirection: .horizontal)
        XCTAssertEqual(sut.scrollDirection, .horizontal)
    }
    
    func test_initSearchResult_whenInitCoder() {
        sut = SearchResultView(coder: NSCoder())
        XCTAssertNil(sut)
    }

    func test_initSearchResult_setCollectionView() {
        XCTAssertTrue(sut.subviews.contains(sut.collectionView))
    }
    
    func test_collectionView_setDelegate() {
        XCTAssertNotNil(sut.collectionView.delegate)
    }
    
    func test_collectionView_setDataSource() {
        XCTAssertNotNil(sut.collectionView.dataSource)
    }
    
    func test_collectionView_setNumberOfSections() {
        XCTAssertEqual(sut.collectionView.dataSource?.numberOfSections?(in: sut.collectionView), 1)
    }
    
    func test_collectionView_setNumberOfItemsInSection() {
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 0)
    }
    
    func test_collectionView_whenGivenViewModel_setNumberOfItemsInSection() {
        sut.viewModels = [whenSetSearchResultViewModel()]
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 1)
    }
    
    func test_collectionView_setCellForRow() {
        sut.viewModels = [whenSetSearchResultViewModel()]
        let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! SearchResultCollectionViewCell
        XCTAssertEqual(cell.ratingLabel.text, "9.9")
    }
    
    func test_collectionView_whenFavoriteSelected_setCellForRow() {
        sut.viewModels = [whenSetSearchResultViewModel()]
        let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! SearchResultCollectionViewCell
        cell.favoriteButtonAction = {
            XCTAssert(true)
        }
        cell.favoriteButtonTapped()
    }
    
    func test_collectionView_setItemSize() {
        sut.viewModels = [whenSetSearchResultViewModel()]
        XCTAssertEqual(sut.collectionView(sut.collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0)), CGSize(width: (UIScreen.main.bounds.width - 48) / 2, height: (((UIScreen.main.bounds.width - 48) / 2) * 233) / 166))
    }
    
    func test_collectionView_setDidSelect() {
        sut.viewModels = [whenSetSearchResultViewModel()]
        sut.resultSelected = { result in
            XCTAssertEqual(result.title, "title")
        }
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
    
    func test_collectionViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.collectionView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_collectionViewAppearance_setKeyboardDismissMode() {
        XCTAssertEqual(sut.collectionView.keyboardDismissMode, .onDrag)
    }
    
    func test_collectionViewAppearance_setShowsHorizontalScrollIndicator() {
        XCTAssertFalse(sut.collectionView.showsHorizontalScrollIndicator)
    }
    
    func test_viewModelsDidChange_setViewModels() {
        sut.viewModels = [whenSetSearchResultViewModel(), whenSetSearchResultViewModel()]
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 2)
    }
    
}
