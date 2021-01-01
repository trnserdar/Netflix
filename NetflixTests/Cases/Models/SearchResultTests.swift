//
//  SearchResultTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 1.01.2021.
//

import XCTest
@testable import Netflix

class SearchResultTests: XCTestCase {

    var sut: SearchResult!
    
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
                                    image2: String? = "https://image2") {
        
        sut = SearchResult(netflixid: netflixid,
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
    
    func test_conformsTo_Decodable() {
      XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func test_conformsTo_Equatable() {
      XCTAssertEqual(sut, sut)
    }

}
