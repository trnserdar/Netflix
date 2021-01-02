//
//  ResultAllCastViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 2.01.2021.
//

import XCTest
@testable import Netflix

class ResultAllCastViewTests: XCTestCase {

    var sut: ResultAllCastView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromResultDetailViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenViewModelSetFromResultDetail(title: String? = "title",
                                    released: String? = "2020",
                                    country: String? = "US",
                                    runtime: String? = "runtime") -> ResultDetailViewModel {
        
        
        let searchResult = SearchResult(netflixid: nil,
                                        title: title,
                                        image: nil,
                                        synopsis: nil,
                                        rating: nil,
                                        type: nil,
                                        released: released,
                                        runtime: nil,
                                        largeimage: nil,
                                        unogsdate: nil,
                                        imdbid: nil,
                                        download: nil,
                                        image1: nil,
                                        matlevel: nil,
                                        matlabel: nil,
                                        avgrating: nil,
                                        updated: nil,
                                        image2: nil)
        let imdbInfo = Imdbinfo(date: nil, production: nil, tomatoConsensus: nil, tomatoUserReviews: nil, metascore: nil, genre: nil, poster: nil, votes: nil, imdbvotes: nil, totalseasons: nil, tomatoFresh: nil, released: nil, awards: nil, type: nil, language: nil, rating: nil, runtime: runtime, plot: nil, rated: nil, tomatoReviews: nil, tomatoMeter: nil, filmid: nil, newid: nil, tomatoRating: nil, imdbid: nil, localimage: nil, tomatoUserRating: nil, top250: nil, imdbtitle: nil, country: country, tomatoUserMeter: nil, top250Tv: nil, tomatoRotten: nil, imdbrating: nil)
        let titleDetail = TitleDetail(nfinfo: searchResult, imdbinfo: imdbInfo, mgname: nil, genreid: nil, people: nil, country: nil)
        return ResultDetailViewModel(titleDetail: titleDetail, favorites: [])
    }
    
    func whenSUTSetFromResultDetailViewModel(viewModel: ResultDetailViewModel? = nil) {
        sut = ResultAllCastView(viewModel: viewModel)
    }

    func test_initResultAllCast_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initResultAllCast_whenViewModelEmpty_setViewModel() {
        XCTAssertNil(sut.viewModel)
    }
    
    func test_initResultAllCast_whenInitCoder() {
        sut = ResultAllCastView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initResultAllCast_setAllCastButton() {
        XCTAssertTrue(sut.subviews.contains(sut.allCastButton))
    }
    
    func test_allCastButtonAppearance_setTitleColor() {
        XCTAssertEqual(sut.allCastButton.titleLabel?.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_allCastButtonAppearance_setTitle() {
        XCTAssertEqual(sut.allCastButton.titleLabel?.text, TextConstants.allCast)
    }

    func test_allCastButtonAppearance_setBorderWidth() {
        XCTAssertEqual(sut.allCastButton.layer.borderWidth, 1.0)
    }

    func test_allCastButtonAppearance_setBorderColor() {
        XCTAssertEqual(sut.allCastButton.layer.borderColor, StyleConstants.Color.darkGray!.cgColor)
    }

    func test_allCastButtonAppearance_setCornerRadius() {
        XCTAssertEqual(sut.allCastButton.layer.cornerRadius, 15.0)
    }
    
    func test_allCastButtonAction_whenGivenViewModel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.allCastButtonAction = { viewModel in
            XCTAssertNotNil(viewModel)
        }
        sut.allCastButtonTapped()
    }

    func test_allCastButtonAction_whenViewModelEmpty() {
        sut.allCastButtonAction = { viewModel in
            XCTFail()
        }
        sut.allCastButtonTapped()
    }
    
}
