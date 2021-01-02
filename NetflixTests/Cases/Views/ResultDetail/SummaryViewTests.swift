//
//  SummaryViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 2.01.2021.
//

import XCTest
@testable import Netflix

class SummaryViewTests: XCTestCase {

    var sut: SummaryView!
    
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
                                    synopsis: String? = "summary",
                                    image: String? = "http://image",
                                    country: String? = "US",
                                    runtime: String? = "runtime",
                                    rating: String? = "9.9") -> ResultDetailViewModel {
        
        
        let searchResult = SearchResult(netflixid: nil,
                                        title: title,
                                        image: nil,
                                        synopsis: synopsis,
                                        rating: nil,
                                        type: nil,
                                        released: released,
                                        runtime: nil,
                                        largeimage: nil,
                                        unogsdate: nil,
                                        imdbid: nil,
                                        download: nil,
                                        image1: image,
                                        matlevel: nil,
                                        matlabel: nil,
                                        avgrating: nil,
                                        updated: nil,
                                        image2: nil)
        let imdbInfo = Imdbinfo(date: nil, production: nil, tomatoConsensus: nil, tomatoUserReviews: nil, metascore: nil, genre: nil, poster: nil, votes: nil, imdbvotes: nil, totalseasons: nil, tomatoFresh: nil, released: nil, awards: nil, type: nil, language: nil, rating: rating, runtime: runtime, plot: nil, rated: nil, tomatoReviews: nil, tomatoMeter: nil, filmid: nil, newid: nil, tomatoRating: nil, imdbid: nil, localimage: nil, tomatoUserRating: nil, top250: nil, imdbtitle: nil, country: country, tomatoUserMeter: nil, top250Tv: nil, tomatoRotten: nil, imdbrating: nil)
        let titleDetail = TitleDetail(nfinfo: searchResult, imdbinfo: imdbInfo, mgname: nil, genreid: nil, people: nil, country: nil)
        return ResultDetailViewModel(titleDetail: titleDetail, favorites: [])
    }
    
    func whenSUTSetFromResultDetailViewModel(viewModel: ResultDetailViewModel? = nil) {
        sut = SummaryView(viewModel: viewModel)
    }
    
    func test_initSummary_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initSummary_whenViewModelEmpty_setViewModel() {
        XCTAssertNil(sut.viewModel)
    }
    
    func test_initSummary_whenInitCoder() {
        sut = SummaryView(coder: NSCoder())
        XCTAssertNil(sut)
    }

    func test_initSummary_whenViewModelEmpty_setImageView() {
        XCTAssertTrue(sut.subviews.contains(sut.imageView))
    }
    
    func test_initSummary_whenViewModelEmpty_setRatingView() {
        XCTAssertFalse(sut.subviews.contains(sut.ratingView))
    }
    
    func test_initSummary_whenViewModelEmpty_setRatingLabel() {
        XCTAssertFalse(sut.ratingView.subviews.contains(sut.ratingLabel))
    }
    
    func test_initSummary_whenViewModelEmpty_setSummaryLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.summaryLabel))
    }
    
    func test_initSummary_whenGivenViewModel_setImageView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.imageView))
    }
    
    func test_initSummary_whenGivenViewModel_setRatingView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.ratingView))
    }
    
    func test_initSummary_whenGivenViewModel_setRatingLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.ratingView.subviews.contains(sut.ratingLabel))
    }
    
    func test_initSummary_whenGivenViewModel_setSummaryLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.summaryLabel))
    }
    
    func test_viewModel_whenViewModelDidSet_setViewModel() {
        sut.viewModel = whenViewModelSetFromResultDetail(synopsis: "summaryTest")
        XCTAssertEqual(sut.summaryLabel.text, "summaryTest")
    }
    
    func test_viewModel_whenViewModelEmptyDidSet_setViewModel() {
        sut.viewModel = nil
        XCTAssert(true)
    }
    
    func test_configureImageView_whenCallMultipleTimes_setImageView() {
        sut.configureImageView()
        XCTAssertTrue(sut.subviews.contains(sut.imageView))
    }
    
    func test_configureRatingView_whenCallMultipleTimes_setRatingView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureRatingView()
        XCTAssertTrue(sut.subviews.contains(sut.ratingView))
    }
    
    func test_configureSummaryLabel_whenCallMultipleTimes_setSummaryLabel() {
        sut.configureSummaryLabel()
        XCTAssertTrue(sut.subviews.contains(sut.summaryLabel))
    }
    
    func test_imageViewAppearance_setContentMode() {
        XCTAssertEqual(sut.imageView.contentMode, .scaleAspectFill)
    }
    
    func test_ratingViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.ratingView.backgroundColor, StyleConstants.Color.turquoise?.withAlphaComponent(0.8))
    }
    
    func test_ratingViewAppearance_setCornerRadius() {
        XCTAssertEqual(sut.ratingView.layer.cornerRadius, 20.0)
    }
    
    func test_ratingLabelAppearance_setFont() {
        XCTAssertEqual(sut.ratingLabel.font, StyleConstants.Font.body)
    }
    
    func test_ratingLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.ratingLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_ratingLabelAppearance_setTextAlignment() {
        XCTAssertEqual(sut.ratingLabel.textAlignment, .center)
    }
    
    func test_ratingLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(rating: "9.9"))
        XCTAssertEqual(sut.ratingLabel.text, "9.9")
    }
    
    func test_ratingLabelAppearance_whenRatingTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(rating: nil))
        XCTAssertEqual(sut.ratingLabel.text, "")
    }
    
    func test_summaryLabelAppearance_setFont() {
        XCTAssertEqual(sut.summaryLabel.font, StyleConstants.Font.body)
    }
    
    func test_summaryLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.summaryLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_summaryLabelAppearance_setNumberOfLines() {
        XCTAssertEqual(sut.summaryLabel.numberOfLines, 0)
    }
    
    func test_summaryLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(synopsis: "summaryTest"))
        XCTAssertEqual(sut.summaryLabel.text, "summaryTest")
    }
    
    func test_summaryLabelAppearance_whenRatingTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(synopsis: nil))
        XCTAssertEqual(sut.summaryLabel.text, "")
    }
    
    func test_configureView_whenGivenViewModel_setRatingLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(rating: "5.5"))
        XCTAssertEqual(sut.ratingLabel.text, "5.5")
    }
    
    func test_configureView_whenGivenViewModel_setSummaryLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(synopsis: "synopsis"))
        XCTAssertEqual(sut.summaryLabel.text, "synopsis")
    }
}
