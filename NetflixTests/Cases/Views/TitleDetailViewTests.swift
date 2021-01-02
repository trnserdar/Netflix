//
//  TitleDetailViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 2.01.2021.
//

import XCTest
@testable import Netflix

class TitleDetailViewTests: XCTestCase {

    var sut: TitleDetailView!
    
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
        sut = TitleDetailView(viewModel: viewModel)
    }
    
    func test_initTitleDetail_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setViewModel() {
        XCTAssertNil(sut.viewModel)
    }
    
    func test_initTitleDetail_whenInitCoder() {
        sut = TitleDetailView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setTitleLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setStackView() {
        XCTAssertTrue(sut.subviews.contains(sut.stackView))
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setYearLabel() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.yearLabel))
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setCountryLabel() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.countryLabel))
    }
    
    func test_initTitleDetail_whenViewModelEmpty_setRuntimeLabel() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.runtimeLabel))
    }
    
    func test_initTitleDetail_whenGivenViewModel_setTitleLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    }
    
    func test_initTitleDetail_whenGivenViewModel_setStackView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.stackView))
    }
    
    func test_initTitleDetail_whenGivenViewModel_setYearLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.yearLabel))
    }
    
    func test_initTitleDetail_whenGivenViewModel_setCountryLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.countryLabel))
    }
    
    func test_initTitleDetail_whenGivenViewModel_setRuntimeLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.runtimeLabel))
    }
    
    func test_viewModel_whenViewModelDidSet_setViewModel() {
        sut.viewModel = whenViewModelSetFromResultDetail(title: "givenTitle")
        XCTAssertEqual(sut.titleLabel.text, "givenTitle")
    }
    
    func test_configureTitleLabel_whenCallMultipleTimes_setTitleLabel() {
        sut.configureTitleLabel()
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    }
    
    func test_configureStackView_whenCallMultipleTimes_setStackView() {
        sut.configureStackView()
        XCTAssertTrue(sut.subviews.contains(sut.stackView))
    }
    
    func test_configureYearLabel_whenCallMultipleTimes_setYearLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureYearLabel()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.yearLabel))
    }
    
    func test_configureCountryLabel_whenCallMultipleTimes_setCountryLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureCountryLabel()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.countryLabel))
    }
    
    func test_configureRuntimeLabel_whenCallMultipleTimes_setRuntimeLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureRuntimeLabel()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.runtimeLabel))
    }
    
    func test_titleLabelAppearance_setFont() {
        XCTAssertEqual(sut.titleLabel.font, StyleConstants.Font.largeTitle)
    }
    
    func test_titleLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.titleLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_titleLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(title: "titleTest"))
        XCTAssertEqual(sut.titleLabel.text, "titleTest")
    }
    
    func test_titleLabelAppearance_whenTitleTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(title: nil))
        XCTAssertEqual(sut.titleLabel.text, "")
    }
    
    func test_titleLabelAppearance_setNumberOfLines() {
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
    }
    
    func test_stackViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.stackView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_stackViewAppearance_setAxis() {
        XCTAssertEqual(sut.stackView.axis, .horizontal)
    }
    
    func test_stackViewAppearance_setAlignment() {
        XCTAssertEqual(sut.stackView.alignment, .fill)
    }
    
    func test_stackViewAppearance_setDistribution() {
        XCTAssertEqual(sut.stackView.distribution, .fill)
    }
    
    func test_stackViewAppearance_setSpacing() {
        XCTAssertEqual(sut.stackView.spacing, 10.0)
    }
    
    func test_yearLabelAppearance_setFont() {
        XCTAssertEqual(sut.yearLabel.font, StyleConstants.Font.body)
    }
    
    func test_yearLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.yearLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_yearLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(released: "released2020"))
        XCTAssertEqual(sut.yearLabel.text, "released2020")
    }
    
    func test_yearLabelAppearance_whenReleasedTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(released: nil))
        XCTAssertEqual(sut.yearLabel.text, "")
    }
    
    func test_countryLabelAppearance_setFont() {
        XCTAssertEqual(sut.countryLabel.font, StyleConstants.Font.body)
    }
    
    func test_countryLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.countryLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_countryLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(country: "US"))
        XCTAssertEqual(sut.countryLabel.text, "US")
    }
    
    func test_countryLabelAppearance_whenCountryTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(country: nil))
        XCTAssertEqual(sut.countryLabel.text, "")
    }
    
    func test_runtimeLabelAppearance_setFont() {
        XCTAssertEqual(sut.runtimeLabel.font, StyleConstants.Font.body)
    }
    
    func test_runtimeLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.runtimeLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_runtimeLabelAppearance_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(runtime: "22m"))
        XCTAssertEqual(sut.runtimeLabel.text, "22m")
    }
    
    func test_runtimeLabelAppearance_whenRuntimeTextEmpty_setText() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail(runtime: nil))
        XCTAssertEqual(sut.runtimeLabel.text, "")
    }
    
    func test_configureView_whenGivenViewModel_setTitleLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(title: "titleTest"))
        XCTAssertEqual(sut.titleLabel.text, "titleTest")
    }
    
    func test_configureView_whenGivenViewModel_setYearLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(released: "releasedYear"))
        XCTAssertEqual(sut.yearLabel.text, "releasedYear")
    }
    
    func test_configureView_whenGivenViewModel_setCountryLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(country: "country us"))
        XCTAssertEqual(sut.countryLabel.text, "country us")
    }
    
    func test_configureView_whenGivenViewModel_setRuntimeLabel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureView(viewModel: whenViewModelSetFromResultDetail(runtime: "10m"))
        XCTAssertEqual(sut.runtimeLabel.text, "10m")
    }
    
}
