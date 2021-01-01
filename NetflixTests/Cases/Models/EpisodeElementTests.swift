//
//  EpisodeElementTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 1.01.2021.
//

import XCTest
@testable import Netflix

class EpisodeElementTests: XCTestCase {

    var sut: EpisodeElement!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromEpisodeElement()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenSUTSetFromEpisodeElement(epnum: String? = "1",
                               title: String? = "title",
                               image: String? = "http://image",
                               synopsis: String? = "summary") {
        
        let episode = Episode(id: nil, seasnum: nil, epnum: epnum, title: title, image: image, synopsis: synopsis, available: nil)
        sut = EpisodeElement(episode: episode)
    }
    
    func test_conformsTo_Decodable() {
      XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func test_conformsTo_Equatable() {
      XCTAssertEqual(sut, sut)
    }
}
