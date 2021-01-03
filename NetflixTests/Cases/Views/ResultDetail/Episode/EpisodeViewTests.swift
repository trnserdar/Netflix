//
//  EpisodeViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 3.01.2021.
//

import XCTest
@testable import Netflix

class EpisodeViewTests: XCTestCase {

    var sut: EpisodeView!
    
    override func setUp() {
        whenSUTSetFromEpisodeViewModel()
        super.setUp()
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
    
    func whenSUTSetFromEpisodeViewModel(viewModels: [EpisodeViewModel] = []) {
        sut = EpisodeView(viewModels: viewModels)
    }
    
    func test_initEpisode_givenViewModel_setViewModel() {
        whenSUTSetFromEpisodeViewModel(viewModels: [whenSetFromEpisode(), whenSetFromEpisode()])
        XCTAssertEqual(sut.viewModels.count, 2)
    }
    
    func test_initEpisode_whenViewModelEmpty_setViewModel() {
        XCTAssertEqual(sut.viewModels.count, 0)
    }
    
    func test_initEpisode_whenInitCoder() {
        sut = EpisodeView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initEpisode_setTableView() {
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
    }
    
    func test_tableView_whenViewModelsDidChange_setHeightConstraint() {
        sut.viewModels = [whenSetFromEpisode(), whenSetFromEpisode()]
        XCTAssertEqual(sut.heightConstraint?.constant, (sut.tableView.contentSize.height * 2))
    }
    
    func test_tableView_setDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_tableView_setDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_tableView_setNumberOfSections() {
        XCTAssertEqual(sut.tableView.dataSource?.numberOfSections?(in: sut.tableView), 1)
    }
    
    func test_tableView_whenViewModelsEmpty_setNumberOfRowsInSection() {
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }
    
    func test_tableView_givenTwoViewModels_setNumberOfRowsInSection() {
        whenSUTSetFromEpisodeViewModel(viewModels: [whenSetFromEpisode(), whenSetFromEpisode()])
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 2)
    }
    
    func test_tableView_setCellForRow() {
        whenSUTSetFromEpisodeViewModel(viewModels: [whenSetFromEpisode(synopsis: "summaryText")])
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! EpisodeTableViewCell
        XCTAssertEqual(cell.summaryLabel.text, "summaryText")
    }
    
    func test_tableViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.tableView.backgroundColor, StyleConstants.Color.lightGray)
    }

    func test_tableViewAppearance_setSeperatorStyle() {
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
    }
    
    func test_tableViewAppearance_setKeyboardDismissMode() {
        XCTAssertEqual(sut.tableView.keyboardDismissMode, .onDrag)
    }
    
    func test_tableViewAppearance_setEstimatedRowHeight() {
        XCTAssertEqual(sut.tableView.estimatedRowHeight, UITableView.automaticDimension)
    }
    
    func test_tableViewAppearance_setRegisterCell() {
        whenSUTSetFromEpisodeViewModel(viewModels: [whenSetFromEpisode()])
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? EpisodeTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func test_tableViewAppearance_setShowsVerticalScrollIndicator() {
        XCTAssertFalse(sut.tableView.showsVerticalScrollIndicator)
    }
    
    func test_tableViewAppearance_setShowsHorizontalScrollIndicator() {
        XCTAssertFalse(sut.tableView.showsHorizontalScrollIndicator)
    }
    
    func test_tableViewAppearance_setIsScrollEnabled() {
        XCTAssertFalse(sut.tableView.isScrollEnabled)
    }
    
    func test_tableViewAppearance_setSectionFooterHeight() {
        XCTAssertEqual(sut.tableView.sectionFooterHeight, 0)
    }

}
