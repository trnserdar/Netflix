//
//  CastViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class CastViewTests: XCTestCase {

    var sut: CastView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromCastViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetViewModelFromPerson(actor: [String]? = ["actor"],
                              creator: [String]? = ["creator"],
                              director: [String]? = ["director"]) -> CastViewModel {
        
        let person = Person(actor: actor, creator: creator, director: director)
        return CastViewModel(person: person)
    }
    
    func whenSUTSetFromCastViewModel(castViewModel: CastViewModel? = nil) {
        sut = CastView(viewModel: castViewModel)
    }
    
    func test_initCast_conformsToBaseView() {
        XCTAssertTrue((sut as Any) is BaseView)
    }
    
    func test_initCast_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initCast_whenInitCoder() {
        sut = CastView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initCast_setTableView() {
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
    }
    
    func test_tableView_setDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_tableView_setDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_tableView_whenViewModelEmpty_setNumberOfSections() {
        XCTAssertEqual(sut.tableView.dataSource?.numberOfSections?(in: sut.tableView), 0)
    }
    
    func test_tableView_givenViewModel_setNumberOfSections() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        XCTAssertEqual(sut.tableView.dataSource?.numberOfSections?(in: sut.tableView), 3)
    }
    
    func test_tableView_whenViewModelEmpty_setNumberOfRowsInSection() {
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }
    
    func test_tableView_givenViewModel_setNumberOfRowsInSection() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 1)
    }
    
    func test_tableView_givenViewModel_setCellForRow() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "director")
    }
    
    func test_tableView_givenViewModel_setCellBackgroundColor() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_tableView_givenViewModel_setCellSelectionStyle() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.selectionStyle, UITableViewCell.SelectionStyle.none)
    }
    
    func test_tableView_givenViewModel_setCellLabelFont() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.font, StyleConstants.Font.body)
    }
    
    func test_tableView_whenViewModelEmpty_setDidSelect() {
        sut.castSelected = { cast in
            XCTFail()
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func test_tableView_givenViewModel_setDidSelect() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        sut.castSelected = { cast in
            XCTAssert(true)
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func test_tableView_whenViewModelEmpty_setTitleForHeader() {
        XCTAssertNil(sut.tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 0))
    }
    
    func test_tableView_givenViewModel_setTitleForHeader() {
        whenSUTSetFromCastViewModel(castViewModel: whenSetViewModelFromPerson())
        XCTAssertNotNil(sut.tableView.dataSource?.tableView?(sut.tableView, titleForHeaderInSection: 0))
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
    
    func test_viewModelDidChange_setCellLabelText() {
        sut.viewModel = whenSetViewModelFromPerson(actor: nil, creator: nil, director: ["directorTest"])
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "directorTest")
    }
    
}
