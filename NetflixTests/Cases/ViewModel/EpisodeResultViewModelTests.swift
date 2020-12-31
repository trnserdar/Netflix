//
//  EpisodeResultViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 31.12.2020.
//

import XCTest
@testable import Netflix

class EpisodeResultViewModelTests: XCTestCase {

    var sut: EpisodeResultViewModel!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromEpisodeResult()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenSUTSetFromEpisodeResult(seasnum: String? = "1",
                                     isSelected: Bool = false) {
        
        let episodeResult = EpisodeResult(seasid: nil, seasnum: seasnum, country: nil, episodes: nil)
        sut = EpisodeResultViewModel(episodeResult: episodeResult, isSelected: isSelected)
    }
    
    func test_initEpisodeResult_setSeasonNameText() {
        XCTAssertEqual(sut.seasonNameText, "1")
    }
    
    func test_initEpisodeResult_whenSeasnumEmpty_setSeasonNameText() {
        whenSUTSetFromEpisodeResult(seasnum: nil)
        XCTAssertEqual(sut.seasonNameText, "")
    }
    
    func test_initEpisodeResult_setItemWidth() {
        XCTAssertEqual(sut.itemWidth, 30.0)
    }
    
    func test_initEpisodeResult_setItemHeight() {
        XCTAssertEqual(sut.itemHeight, 30.0)
    }
    
    func test_initEpisodeResult_setBorderColor() {
        XCTAssertEqual(sut.borderColor, StyleConstants.Color.lightGray!)
    }
    
    func test_initEpisodeResult_whenIsSelectedTrue_setBorderColor() {
        whenSUTSetFromEpisodeResult(isSelected: true)
        XCTAssertEqual(sut.borderColor, StyleConstants.Color.darkGray!)
    }
}
