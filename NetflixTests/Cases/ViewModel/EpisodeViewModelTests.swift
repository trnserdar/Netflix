//
//  EpisodeViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 31.12.2020.
//

import XCTest
@testable import Netflix

class EpisodeViewModelTests: XCTestCase {

    var sut: EpisodeViewModel!
    
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
        
        let episode = Episode(id: nil, seasnum: nil, epnum: epnum, title: title, image: image, synopsis: synopsis, available: nil)
        sut = EpisodeViewModel(episode: episode)
    }
    
    func test_initEpisode_setImage() {
        XCTAssertEqual(sut.imageURL, URL(string: "http://image"))
    }
    
    func test_initEpisode_whenImageEmpty_setImage() {
        whenSUTSetFromEpisode(image: nil)
        XCTAssertNil(sut.imageURL)
    }
    
    func test_initEpisode_setTitleText() {
        XCTAssertEqual(sut.titleText, "1. title")
    }
    
    func test_initEpisode_whenEpnumEmpty_setTitleText() {
        whenSUTSetFromEpisode(epnum: nil)
        XCTAssertEqual(sut.titleText, "title")
    }
    
    func test_initEpisode_whenTitleEmpty_setTitleText() {
        whenSUTSetFromEpisode(title: nil)
        XCTAssertEqual(sut.titleText, "1. ")
    }
    
    func test_initEpisode_whenEpnumAndTitleEmpty_setTitleText() {
        whenSUTSetFromEpisode(epnum: nil, title: nil)
        XCTAssertEqual(sut.titleText, "")
    }
    
    func test_initEpisode_setSummaryText() {
        XCTAssertEqual(sut.summaryText, "summary")
    }
    
    func test_initEpisode_whenSynopsisEmpty_setSummaryText() {
        whenSUTSetFromEpisode(synopsis: nil)
        XCTAssertEqual(sut.summaryText, "")
    }
}
