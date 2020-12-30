//
//  SearchResultViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 30.12.2020.
//

import XCTest
@testable import Netflix

class SearchResultViewModelTests: XCTestCase {

    var sut: SearchResultViewModel!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromSearchResult()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSUTSetFromSearchResult(netflixid: String? = "81393502",
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
                                    favorites: [TitleDetail] = [TitleDetail.dummy]) {
        
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
        sut = SearchResultViewModel(searchResult: searchResult, sizeOption: sizeOption, favorites: favorites)
    }
    
    func test_initSearchResult_setItemWidth() {
        XCTAssertEqual(sut.itemWidth, (UIScreen.main.bounds.width - 48) / 2)
    }
    
    func test_initSearchResult_whenSizeNotSmall_setItemWidth() {
        whenSUTSetFromSearchResult(sizeOption: .big)
        XCTAssertEqual(sut.itemWidth, 284)
    }

    func test_initSearchResult_setItemHeight() {
        XCTAssertEqual(sut.itemHeight, (sut.itemWidth * 233) / 166)
    }
    
    func test_initSearchResult_whenSizeNotSmall_setItemHeight() {
        whenSUTSetFromSearchResult(sizeOption: .big)
        XCTAssertEqual(sut.itemHeight, 398)
    }
    
    func test_initSearchResult_setImage() {
        XCTAssertEqual(sut.imageURL, URL(string: "https://image"))
    }
    
    func test_initSearchResult_whenImageNil_setImage() {
        whenSUTSetFromSearchResult(image: nil)
        XCTAssertEqual(sut.imageURL, URL(string: "https://image1"))
    }

    func test_initSearchResult_whenImageAndImage1Nil_setImage() {
        whenSUTSetFromSearchResult(image: nil, image1: nil)
        XCTAssertEqual(sut.imageURL, URL(string: "https://image2"))
    }
    
    func test_initSearchResult_whenSmallImagesNil_setImage() {
        whenSUTSetFromSearchResult(image: nil, image1: nil, image2: nil)
        XCTAssertNil(sut.imageURL)
    }
    
    func test_initSearchResult_whenSizeOptionNotSmall_setImage() {
        whenSUTSetFromSearchResult(sizeOption: .big)
        XCTAssertEqual(sut.imageURL, URL(string: "https://largeImage"))
    }

    func test_initSearchResult_whenSizeOptionNotSmall_largeImageNil_setImage() {
        whenSUTSetFromSearchResult(largeimage: nil, sizeOption: .big)
        XCTAssertEqual(sut.imageURL, URL(string: "https://image1"))
    }
    
    func test_initSearchResult_whenSizeOptionNotSmall_largeImageAndImage1Nil_setImage() {
        whenSUTSetFromSearchResult(largeimage: nil, image1: nil, sizeOption: .big)
        XCTAssertEqual(sut.imageURL, URL(string: "https://image2"))
    }
    
    func test_initSearchResult_whenSizeOptionNotSmall_imagesNil_setImage() {
        whenSUTSetFromSearchResult(largeimage: nil, image1: nil, image2: nil, sizeOption: .big)
        XCTAssertNil(sut.imageURL)
    }
    
    func test_initSearchResult_setRatingIsHidden() {
        XCTAssertFalse(sut.ratingIsHidden)
    }
    
    func test_initSearchResult_whenRatingEmpty_setRatingIsHidden() {
        whenSUTSetFromSearchResult(rating: nil)
        XCTAssertTrue(sut.ratingIsHidden)
    }

    func test_initSearchResult_setRatingText() {
        XCTAssertEqual(sut.ratingText, "9.9")
    }

    func test_initSearchResult_whenRatingEmpty_setRatingText() {
        whenSUTSetFromSearchResult(rating: nil)
        XCTAssertEqual(sut.ratingText, "")
    }
    
    func test_initSearchResult_setFavoriteButtonImage() {
        XCTAssertEqual(sut.favoriteButtonImage, StyleConstants.Image.heartFill)
    }
    
    func test_initSearchResult_whenFavoritesEmpty_setFavoriteButtonImage() {
        whenSUTSetFromSearchResult(favorites: [])
        XCTAssertEqual(sut.favoriteButtonImage, StyleConstants.Image.heart)
    }
}
