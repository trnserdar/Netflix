//
//  ResultEpisodeViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 3.01.2021.
//

import XCTest
@testable import Netflix

class ResultEpisodeViewTests: XCTestCase {

    var sut: ResultEpisodeView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromEpisodeResultViewModelsAndEpisodeViewModels()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetEpisodeViewModelFromEpisode(id: String? = "id",
                                            seasnum: String? = "seasnum",
                                            epnum: String? = "epnum",
                                            title: String? = "title",
                                            image: String? = "http://image",
                                            synopsis: String? = "summary",
                                            available: String? = "available") -> EpisodeViewModel {
        return EpisodeViewModel(episode: Episode(id: id, seasnum: seasnum, epnum: epnum, title: title, image: image, synopsis: synopsis, available: available))
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
    
    func whenSUTSetFromEpisodeResultViewModelsAndEpisodeViewModels(episodeResultViewModels: [EpisodeResultViewModel] = [], episodeViewModels: [EpisodeViewModel] = []) {
        sut = ResultEpisodeView(episodeResultViewModels: episodeResultViewModels, episodeViewModels: episodeViewModels)
    }
    
    func test_initResultEpisode_whenViewModelEmpty_setEpisodeResultViewModels() {
        XCTAssertTrue(sut.episodeResultViewModels.isEmpty)
    }
    
    func test_initResultEpisode_whenViewModelEmpty_setEpisodeViewModels() {
        XCTAssertTrue(sut.episodeViewModels.isEmpty)
    }
    
    func test_initResultEpisode_givenViewModels_setEpisodeResultViewModels() {
        whenSUTSetFromEpisodeResultViewModelsAndEpisodeViewModels(episodeResultViewModels: [whenSetEpisodeResultViewModelFromEpisode()])
        XCTAssertFalse(sut.episodeResultViewModels.isEmpty)
    }
    
    func test_initResultEpisode_givenViewModels_setEpisodeViewModels() {
        whenSUTSetFromEpisodeResultViewModelsAndEpisodeViewModels(episodeViewModels: [whenSetEpisodeViewModelFromEpisode()])
        XCTAssertFalse(sut.episodeViewModels.isEmpty)
    }

    func test_initResultEpisode_whenInitCoder() {
        sut = ResultEpisodeView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initResultEpisode_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initResultEpisode_setSeasonView() {
        XCTAssertTrue(sut.subviews.contains(sut.seasonView))
    }

    func test_initResultEpisode_setEpisodeView() {
        XCTAssertTrue(sut.subviews.contains(sut.episodeView))
    }
    
    func test_episodeResultViewModels_whenGiven3ViewModels_setSeasonViewViewModels() {
        sut.episodeResultViewModels = [whenSetEpisodeResultViewModelFromEpisode(), whenSetEpisodeResultViewModelFromEpisode(), whenSetEpisodeResultViewModelFromEpisode()]
        XCTAssertEqual(sut.seasonView.viewModels.count, 3)
    }
    
    func test_episodeResultViewModels_whenGiven2ViewModels_setSeasonViewViewModels() {
        sut.episodeResultViewModels = [whenSetEpisodeResultViewModelFromEpisode(), whenSetEpisodeResultViewModelFromEpisode()]
        XCTAssertEqual(sut.seasonView.viewModels.count, 2)
    }
    
    func test_episodeViewModels_whenGiven3ViewModels_setEpisodeViewViewModels() {
        sut.episodeViewModels = [whenSetEpisodeViewModelFromEpisode(), whenSetEpisodeViewModelFromEpisode(), whenSetEpisodeViewModelFromEpisode()]
        XCTAssertEqual(sut.episodeView.viewModels.count, 3)
    }

    func test_episodeViewModels_whenGiven2ViewModels_setEpisodeViewViewModels() {
        sut.episodeViewModels = [whenSetEpisodeViewModelFromEpisode(), whenSetEpisodeViewModelFromEpisode()]
        XCTAssertEqual(sut.episodeView.viewModels.count, 2)
    }
    
    func test_seasonSelected_setViewModels() {
        sut.episodeResultViewModels = [whenSetEpisodeResultViewModelFromEpisode(id: "id1", seasnum: "season1", epnum: "ep1", title: "title1", image: "image1", synopsis: "synopsis1", available: "available1", seasid: "seasoid1", country: "country1", isSelected: false), whenSetEpisodeResultViewModelFromEpisode(id: "id2", seasnum: "season2", epnum: "ep2", title: "title2", image: "image2", synopsis: "synopsis2", available: "available2", seasid: "seasoid2", country: "country2", isSelected: false),]
        
        sut.seasonView.seasonSelected = { viewModel in
            XCTAssertEqual(self.sut.episodeViewModels.count, 1)
            XCTAssertEqual(self.sut.episodeResultViewModels[0].episodeResult.seasnum,
                           "season1")
            XCTAssertEqual(self.sut.episodeResultViewModels[0].episodeResult, viewModel.episodeResult)
        }
        
        sut.seasonView.collectionView.delegate?.collectionView?(sut.seasonView.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

}
