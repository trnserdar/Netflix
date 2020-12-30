//
//  ResultDetailViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 30.12.2020.
//

import XCTest
@testable import Netflix

class ResultDetailViewModelTests: XCTestCase {

    var sut: ResultDetailViewModel!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromResultDetail()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSUTSetFromResultDetail(netflixid: String? = "81393502",
                                    title: String? = "title",
                                    synopsis: String? = "synopsis",
                                    type: String? = "movie",
                                    image1: String? = "https://image1",
                                    released: String? = "2020",
                                    country: String? = "US",
                                    runtime: String? = "55m",
                                    rating: String? = "9.9",
                                    person: [Person]? = [Person(actor: ["ABC"], creator: nil, director: nil)],
                                    favorites: [TitleDetail] = [TitleDetail.dummy]) {
        
        
        let searchResult = SearchResult(netflixid: netflixid,
                                        title: title,
                                        image: nil,
                                        synopsis: synopsis,
                                        rating: nil,
                                        type: type,
                                        released: released,
                                        runtime: nil,
                                        largeimage: nil,
                                        unogsdate: nil,
                                        imdbid: nil,
                                        download: nil,
                                        image1: image1,
                                        matlevel: nil,
                                        matlabel: nil,
                                        avgrating: nil,
                                        updated: nil,
                                        image2: nil)
        let imdbInfo = Imdbinfo(date: nil, production: nil, tomatoConsensus: nil, tomatoUserReviews: nil, metascore: nil, genre: nil, poster: nil, votes: nil, imdbvotes: nil, totalseasons: nil, tomatoFresh: nil, released: nil, awards: nil, type: nil, language: nil, rating: rating, runtime: runtime, plot: nil, rated: nil, tomatoReviews: nil, tomatoMeter: nil, filmid: nil, newid: nil, tomatoRating: nil, imdbid: nil, localimage: nil, tomatoUserRating: nil, top250: nil, imdbtitle: nil, country: country, tomatoUserMeter: nil, top250Tv: nil, tomatoRotten: nil, imdbrating: nil)
        let titleDetail = TitleDetail(nfinfo: searchResult, imdbinfo: imdbInfo, mgname: ["Genre Name"], genreid: ["Genre Id"], people: person, country: nil)
        sut = ResultDetailViewModel(titleDetail: titleDetail, favorites: favorites)
    }
    
    func test_initResultDetail_setTitle() {
        XCTAssertEqual(sut.titleText, "title")
    }
    
    func test_initResultDetail_whenTitleEmpty_setTitle() {
        whenSUTSetFromResultDetail(title: nil)
        XCTAssertEqual(sut.titleText, "")
    }

    func test_initResultDetail_setReleaseDateIsEnabled() {
        XCTAssertTrue(sut.releaseDateIsEnabled)
    }
    
    func test_initResultDetail_whenReleaseEmpty_setReleaseDateIsEnabled() {
        whenSUTSetFromResultDetail(released: nil)
        XCTAssertFalse(sut.releaseDateIsEnabled)
    }
    
    func test_initResultDetail_setReleaseDateText() {
        XCTAssertEqual(sut.releaseDateText, "2020")
    }
    
    func test_initResultDetail_whenReleaseEmpty_setReleaseDateText() {
        whenSUTSetFromResultDetail(released: nil)
        XCTAssertEqual(sut.releaseDateText, "")
    }
    
    func test_initResultDetail_setCountryIsEnabled() {
        XCTAssertTrue(sut.countryIsEnabled)
    }
    
    func test_initResultDetail_whenCountryEmpty_setCountryIsEnabled() {
        whenSUTSetFromResultDetail(country: nil)
        XCTAssertFalse(sut.countryIsEnabled)
    }
    
    func test_initResultDetail_setCountryText() {
        XCTAssertEqual(sut.countryText, "US")
    }
    
    func test_initResultDetail_whenCountryEmpty_setCountryText() {
        whenSUTSetFromResultDetail(country: nil)
        XCTAssertEqual(sut.countryText, "")
    }
    
    func test_initResultDetail_setRuntimeIsEnabled() {
        XCTAssertTrue(sut.runtimeIsEnabled)
    }
    
    func test_initResultDetail_whenRuntimeEmpty_setRuntimeIsEnabled() {
        whenSUTSetFromResultDetail(runtime: nil)
        XCTAssertFalse(sut.runtimeIsEnabled)
    }
    
    func test_initResultDetail_setRuntimeText() {
        XCTAssertEqual(sut.countryText, "US")
    }
    
    func test_initResultDetail_whenRuntimeEmpty_setRuntimeText() {
        whenSUTSetFromResultDetail(runtime: nil)
        XCTAssertEqual(sut.runtimeText, "")
    }
    
    func test_initResultDetail_setImage() {
        XCTAssertEqual(sut.imageURL, URL(string: "https://image1"))
    }
    
    func test_initResultDetail_whenImage1Empty_setImage() {
        whenSUTSetFromResultDetail(image1: nil)
        XCTAssertNil(sut.imageURL)
    }
    
    func test_initResultDetail_setRatingIsEnabled() {
        XCTAssertTrue(sut.ratingIsEnabled)
    }
    
    func test_initResultDetail_whenRating0_setRatingIsEnabled() {
        whenSUTSetFromResultDetail(rating: "0")
        XCTAssertFalse(sut.ratingIsEnabled)
    }
    
    func test_initResultDetail_whenRatingEmpty_setRatingIsEnabled() {
        whenSUTSetFromResultDetail(rating: nil)
        XCTAssertFalse(sut.ratingIsEnabled)
    }
    
    func test_initResultDetail_setRatingText() {
        XCTAssertEqual(sut.ratingText, "9.9")
    }
    
    func test_initResultDetail_whenRatingEmpty_setRatingText() {
        whenSUTSetFromResultDetail(rating: nil)
        XCTAssertEqual(sut.ratingText, "")
    }
    
    func test_initResultDetail_setSummaryText() {
        XCTAssertEqual(sut.summaryText, "synopsis")
    }
    
    func test_initResultDetail_whenSynopsisEmpty_setSummaryText() {
        whenSUTSetFromResultDetail(synopsis: nil)
        XCTAssertEqual(sut.summaryText, "")
    }
    
    func test_initResultDetail_setGenreViewModels() {
        XCTAssertEqual(sut.genreViewModels.count, 1)
    }
    
    func test_initResultDetail_setAllCastIsEnabled() {
        XCTAssertTrue(sut.allCastIsEnabled)
    }
    
    func test_initResultDetail_whenPeopleEmpty_setAllCastIsEnabled() {
        whenSUTSetFromResultDetail(person: nil)
        XCTAssertFalse(sut.allCastIsEnabled)
    }
    
    func test_initResultDetail_setEpisodeIsEnabled() {
        XCTAssertFalse(sut.episodesIsEnabled)
    }
    
    func test_initResultDetail_whenSeriesEpisode_setEpisodeIsEnabled() {
        whenSUTSetFromResultDetail(type: "series")
        XCTAssertTrue(sut.episodesIsEnabled)
    }
    
    func test_initResultDetail_setFavoriteButtonImage() {
        XCTAssertEqual(sut.favoriteButtonImage, StyleConstants.Image.heartFill)
    }
    
    func test_initResultDetail_whenFavoritesEmpty_setFavoriteButtonImage() {
        whenSUTSetFromResultDetail(favorites: [])
        XCTAssertEqual(sut.favoriteButtonImage, StyleConstants.Image.heart)
    }
}
