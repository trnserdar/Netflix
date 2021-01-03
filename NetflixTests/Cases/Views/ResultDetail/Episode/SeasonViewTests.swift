//
//  SeasonViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 3.01.2021.
//

import XCTest
@testable import Netflix

class SeasonViewTests: XCTestCase {

    var sut: SeasonView!

    override func setUp() {
        super.tearDown()
        whenSUTSetFromViewModels()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetEpisodeResultViewModelFromEpisode(id: String? = "id",
                                                  seasnum: String? = "seasnum",
                                                  epnum: String? = "epnum",
                                                  title: String? = "title",
                                                  image: String? = "http://image",
                                                  synopsis: String? = "summary",
                                                  available: String? = "available",
                                                  seasid: String? = "seasid",
                                                  country: String? = "country",
                                                  isSelected: Bool = false) -> EpisodeResultViewModel {
        let episode = Episode(id: id, seasnum: seasnum, epnum: epnum, title: title, image: image, synopsis: synopsis, available: available)
        let episodeElements = [EpisodeElement(episode: episode)]
        let episodeResult = EpisodeResult(seasid: seasid, seasnum: seasnum, country: country, episodes: episodeElements)
        return EpisodeResultViewModel(episodeResult: episodeResult, isSelected: isSelected)
    }
    
    func whenSUTSetFromViewModels(episodeResultViewModels: [EpisodeResultViewModel] = []) {
        sut = SeasonView(viewModels: episodeResultViewModels)
    }
    
    func test_initSeason_whenViewModelEmpty_setViewModels() {
        XCTAssertTrue(sut.viewModels.isEmpty)
    }
    
    func test_initSeason_givenViewModel_setViewModels() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode()])
        XCTAssertFalse(sut.viewModels.isEmpty)
    }
    
    func test_initSeason_given2ViewModels_setViewModels() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode(), whenSetEpisodeResultViewModelFromEpisode()])
        XCTAssertEqual(sut.viewModels.count, 2)
    }

    func test_initSeason_whenInitCoder() {
        sut = SeasonView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initSeason_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initSeason_setTitleLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
    }
    
    func test_initSeason_setCollectionView() {
        XCTAssertTrue(sut.subviews.contains(sut.collectionView))
    }
    
    func test_collectionView_givenViewModel_setHeightConstraint() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode()])
        XCTAssertEqual(sut.heightConstraint?.constant, sut.collectionView.contentSize.height)
    }
    
    func test_collectionView_whenViewModelsDidChange_setHeightConstraint() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum1"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum2"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum3"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum4"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum5"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum6"), whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnum7")])
        
        XCTAssertEqual(sut.heightConstraint?.constant, sut.collectionView.contentSize.height)
    }
    
    func test_collectionView_setDelegate() {
        XCTAssertNotNil(sut.collectionView.delegate)
    }
    
    func test_collectionView_setDataSource() {
        XCTAssertNotNil(sut.collectionView.dataSource)
    }
    
    func test_collectionView_setNumberOfSections() {
        XCTAssertEqual(sut.collectionView.dataSource?.numberOfSections?(in: sut.collectionView), 1)
    }
    
    func test_collectionView_setNumberOfRowsInSection() {
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 0)
    }
    
    func test_collectionView_whenGiven2ViewModels_setNumberOfRowsInSection() {
        sut.viewModels = [whenSetEpisodeResultViewModelFromEpisode(), whenSetEpisodeResultViewModelFromEpisode()]
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 2)
    }
    
    func test_collectionView_setCellForRow() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode(seasnum: "seasnumTest")])
        let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! SeasonCollectionViewCell
        XCTAssertEqual(cell.label.text, "seasnumTest")
    }
    
    func test_collectionView_setHeightForRow() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode()])
        XCTAssertEqual(sut.collectionView(sut.collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0)), CGSize(width: 30.0, height: 30.0))
    }

    func test_collectionView_setDidSelect() {
        whenSUTSetFromViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode()])
        sut.seasonSelected = { viewModel in
            XCTAssert(true)
        }
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
    
    func test_titleLabelAppearance_setFont() {
        XCTAssertEqual(sut.titleLabel.font, StyleConstants.Font.title2)
    }
    
    func test_titleLabelAppearance_setTextColor() {
        XCTAssertEqual(sut.titleLabel.textColor, StyleConstants.Color.darkGray)
    }
    
    func test_titleLabelAppearance_setText() {
        XCTAssertEqual(sut.titleLabel.text, TextConstants.seasons)
    }
    
    func test_collectionViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.collectionView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_collectionViewAppearance_setKeyboardDismissMode() {
        XCTAssertEqual(sut.collectionView.keyboardDismissMode, .onDrag)
    }

}
