//
//  ResultDetailViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class ResultDetailViewTests: XCTestCase {

    var sut: ResultDetailView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromResultDetailViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenViewModelSetFromResultDetail(type: String? = "series",
                                    people: [Person]? = [Person(actor: ["actor"], creator: nil, director: nil)]) -> ResultDetailViewModel {
        
        
        let searchResult = SearchResult(netflixid: nil,
                                        title: nil,
                                        image: nil,
                                        synopsis: nil,
                                        rating: nil,
                                        type: type,
                                        released: nil,
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
        let imdbInfo = Imdbinfo(date: nil, production: nil, tomatoConsensus: nil, tomatoUserReviews: nil, metascore: nil, genre: nil, poster: nil, votes: nil, imdbvotes: nil, totalseasons: nil, tomatoFresh: nil, released: nil, awards: nil, type: nil, language: nil, rating: nil, runtime: nil, plot: nil, rated: nil, tomatoReviews: nil, tomatoMeter: nil, filmid: nil, newid: nil, tomatoRating: nil, imdbid: nil, localimage: nil, tomatoUserRating: nil, top250: nil, imdbtitle: nil, country: nil, tomatoUserMeter: nil, top250Tv: nil, tomatoRotten: nil, imdbrating: nil)
        let titleDetail = TitleDetail(nfinfo: searchResult, imdbinfo: imdbInfo, mgname: nil, genreid: nil, people: people, country: nil)
        return ResultDetailViewModel(titleDetail: titleDetail, favorites: [])
    }
    
    func whenSUTSetFromResultDetailViewModel(viewModel: ResultDetailViewModel? = nil) {
        sut = ResultDetailView(viewModel: viewModel)
    }
    
    func test_initResultDetail_conformsToBaseView() {
        XCTAssertTrue((sut as Any) is BaseView)
    }
    
    func test_initResultDetail_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initResultDetail_whenInitCoder() {
        sut = ResultDetailView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initResultDetail_whenViewModelEmpty_setScrollView() {
        XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setStackView() {
        XCTAssertTrue(sut.scrollView.subviews.contains(sut.stackView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setTitleDetailView() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.titleDetailView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setSummaryView() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.summaryView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setResultCategoryView() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.resultCategoryView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setAllCastView() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.resultAllCastView))
    }
    
    func test_initResultDetail_whenViewModelEmpty_setResultEpisodeView() {
        XCTAssertFalse(sut.stackView.subviews.contains(sut.resultEpisodeView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setScrollView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setStackView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.scrollView.subviews.contains(sut.stackView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setTitleDetailView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.titleDetailView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setSummaryView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.summaryView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setResultCategoryView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultCategoryView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setAllCastView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultAllCastView))
    }
    
    func test_initResultDetail_whenGivenViewModel_setResultEpisodeView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultEpisodeView))
    }
    
    func test_configureView_setImage() {
        let viewModel = whenViewModelSetFromResultDetail()
        sut.configureView(viewModel: viewModel)
        XCTAssertEqual(sut.favoriteBarButtonItem.image, viewModel.favoriteButtonImage)
    }
    
    func test_favoriteBarButtonItemTapped_whenViewModelEmpty() {
        sut.favoriteSelected = { nfInfo in
            XCTFail()
        }
        sut.favoriteBarButtonItemTapped()
    }
    
    func test_favoriteBarButtonItemTapped_whenGivenViewModel() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.favoriteSelected = { nfInfo in
            XCTAssert(true)
        }
        sut.favoriteBarButtonItemTapped()
    }
    
    func test_configureScrollView_whenCallMultipleTimes_setScrollView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureScrollView()
        XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    }
    
    func test_configureStackView_whenCallMultipleTimes_setStackView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureStackView()
        XCTAssertTrue(sut.scrollView.subviews.contains(sut.stackView))
    }
    
    func test_configureTitleDetailView_whenCallMultipleTimes_setTitleDetailView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureTitleDetailView()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.titleDetailView))
    }
    
    func test_configureSummaryView_whenCallMultipleTimes_setSummaryView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureSummaryView()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.summaryView))
    }
    
    func test_configureResultCategoryView_whenCallMultipleTimes_setResultCategoryView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureResultCategoryView()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultCategoryView))
    }
    
    func test_configureAllCastView_whenCallMultipleTimes_setAllCastView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureResultAllCastView()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultAllCastView))
    }
    
    func test_configureEpisodeView_whenCallMultipleTimes_setEpisodeView() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.configureResultEpisodeView()
        XCTAssertTrue(sut.stackView.subviews.contains(sut.resultEpisodeView))
    }
    
    func test_viewModelDidSet_whenGivenViewModel_setImage() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        let viewModel = whenViewModelSetFromResultDetail()
        sut.viewModel = viewModel
        XCTAssertEqual(sut.favoriteBarButtonItem.image, viewModel.favoriteButtonImage)
    }
    
    func test_viewModelDidSet_whenEmptyViewModel_setImage() {
        whenSUTSetFromResultDetailViewModel(viewModel: whenViewModelSetFromResultDetail())
        sut.viewModel = nil
        XCTAssertTrue(sut.subviews.contains(sut.scrollView))
    }
}
