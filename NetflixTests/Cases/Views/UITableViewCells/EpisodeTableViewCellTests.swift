//
//  EpisodeTableViewCellTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 3.01.2021.
//

import XCTest
@testable import Netflix

class EpisodeTableViewCellTests: XCTestCase {

    var sut: EpisodeTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = EpisodeTableViewCell()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func whenSetFromEpisode(id: String? = "id",
                            seasnum: String? = "seasnum",
                            epnum: String? = "epnum",
                            title: String? = "title",
                            image: String? = "http://image",
                            synopsis: String? = "summary",
                            available: String? = "available") -> EpisodeViewModel {
        return EpisodeViewModel(episode: Episode(id: id, seasnum: seasnum, epnum: epnum, title: title, image: image, synopsis: synopsis, available: available))
    }
    
    func test_initEpisodeTableViewCell_whenInitCoder() {
        sut = EpisodeTableViewCell(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initEpisodeTableViewCell_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }

    func test_initEpisodeTableViewCell_setImageView() {
        XCTAssertTrue(sut.subviews.contains(sut.episodeImageView))
    }
    
    func test_initEpisodeTableViewCell_setTitleLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    }
    
    func test_initEpisodeTableViewCell_setSummaryLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.summaryLabel))
    }
    
    func test_episodeImageViewAppearance_setContentMode() {
        XCTAssertEqual(sut.episodeImageView.contentMode, .scaleAspectFill)
    }
    
    func test_titleLabelAppearance_setFont() {
        XCTAssertEqual(sut.titleLabel.font, StyleConstants.Font.body)
    }
    
    func test_titleLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.titleLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_titleLabelAppearance_setTextAligment() {
        XCTAssertEqual(sut.titleLabel.textAlignment, .left)
    }
    
    func test_titleLabelAppearance_setNumberOfLines() {
        XCTAssertEqual(sut.titleLabel.numberOfLines, 2)
    }
    
    func test_summaryLabelAppearance_setFont() {
        XCTAssertEqual(sut.summaryLabel.font, StyleConstants.Font.footnote)
    }
    
    func test_summaryLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.summaryLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_summaryLabelAppearance_setNumberOfLines() {
        XCTAssertEqual(sut.summaryLabel.numberOfLines, 0)
    }
    
    func test_configureCell_givenViewModel_setTitleLabel() {
        sut.configureCell(viewModel: whenSetFromEpisode())
        XCTAssertEqual(sut.titleLabel.text, "epnum. title")
    }
    
    func test_configureCell_givenViewModel_setSummaryLabel() {
        sut.configureCell(viewModel: whenSetFromEpisode(synopsis: "summaryTest"))
        XCTAssertEqual(sut.summaryLabel.text, "summaryTest")
    }
}
