//
//  TitleDetailTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 1.01.2021.
//

import XCTest
@testable import Netflix

class TitleDetailTests: XCTestCase {

    var sut: TitleDetail!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromTitleDetail()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSUTSetFromTitleDetail(netflixid: String? = "81393502",
                                    title: String? = "title",
                                    synopsis: String? = "synopsis",
                                    type: String? = "movie",
                                    image1: String? = "https://image1",
                                    released: String? = "2020",
                                    country: String? = "US",
                                    runtime: String? = "55m",
                                    rating: String? = "9.9",
                                    mgName: [String]? = ["Genre name"],
                                    genreId: [String]? = ["Genre id"],
                                    actor: [String]? = ["actor"],
                                    creator: [String]? = ["creator"],
                                    director: [String]? = ["director"]) {
        
        
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
        let person = Person(actor: actor, creator: creator, director: director)
        sut = TitleDetail(nfinfo: searchResult, imdbinfo: imdbInfo, mgname: mgName, genreid: genreId, people: [person], country: nil)
    }

    func test_initTitleDetail_setGenres() {
        XCTAssertEqual(sut.genres.count, 1)
    }
    
    func test_initTitleDetail_whenGenresTwo_setGenres() {
        whenSUTSetFromTitleDetail(mgName: ["a", "b"], genreId: ["1", "2"])
        XCTAssertEqual(sut.genres.count, 2)
    }
    
    func test_initTitleDetail_whenGenresEmpty_setGenres() {
        whenSUTSetFromTitleDetail(mgName: nil, genreId: nil)
        XCTAssertEqual(sut.genres.count, 0)
    }
    
    func test_initTitleDetail_setCastActor() {
        XCTAssertEqual(sut.cast?.actor, ["actor"])
    }
    
    func test_initTitleDetail_setCastCreator() {
        XCTAssertEqual(sut.cast?.creator, ["creator"])
    }
    
    func test_initTitleDetail_setCastDirector() {
        XCTAssertEqual(sut.cast?.director, ["director"])
    }
}
