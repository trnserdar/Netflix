//
//  EpisodeResultTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 1.01.2021.
//

import XCTest
@testable import Netflix

class EpisodeResultTests: XCTestCase {

    var sut: EpisodeResult!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromEpisodeResult()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenSUTSetFromEpisodeResult(seasid: String? = "1",
                                     seasnum: String? = "num",
                                     country: String? = "country",
                                     epnum: String? = "1",
                                     title: String? = "title",
                                     image: String? = "http://image",
                                     synopsis: String? = "summary") {
        
        let episode = Episode(id: nil, seasnum: nil, epnum: epnum, title: title, image: image, synopsis: synopsis, available: nil)
        let episodeElement = EpisodeElement(episode: episode)
        sut = EpisodeResult(seasid: seasid, seasnum: seasnum, country: country, episodes: [episodeElement])
    }
    
    func test_conformsTo_Decodable() {
      XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func test_conformsTo_Equatable() {
      XCTAssertEqual(sut, sut)
    }

}
