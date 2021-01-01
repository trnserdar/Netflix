//
//  EpisodeTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 1.01.2021.
//

import XCTest
@testable import Netflix

class EpisodeTests: XCTestCase {

    var sut: Episode!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromEpisode()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenSUTSetFromEpisode(epnum: String? = "1",
                               title: String? = "title",
                               image: String? = "http://image",
                               synopsis: String? = "summary") {
        
        sut = Episode(id: nil, seasnum: nil, epnum: epnum, title: title, image: image, synopsis: synopsis, available: nil)
    }
    
    func test_conformsTo_Decodable() {
      XCTAssertTrue((sut as Any) is Decodable)
    }
    
    func test_conformsTo_Equatable() {
      XCTAssertEqual(sut, sut)
    }

}
