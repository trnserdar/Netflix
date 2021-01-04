//
//  GenresViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class GenresViewTests: XCTestCase {

    var sut: GenresView!
    
    override func setUp() {
        super.setUp()
        sut = GenresView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenGetGenreViewModel(name: String = "Action",
                             ids: [Int]? = [801362]) -> GenreViewModel {
        
        let genre = Genre(name: name,
                          ids: ids)
        return GenreViewModel(genre: genre)
    }
    
    func test_initGenres_whenInitCoder() {
        sut = GenresView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initGenres_conformsToBaseView() {
        XCTAssertTrue((sut as Any) is BaseView)
    }
    
    func test_initGenres_setSearchBar() {
        XCTAssertTrue(sut.subviews.contains(sut.searchBar))
    }
    
    func test_initGenres_setTableView() {
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
    }
    
    func test_searchBar_setDelegate() {
        XCTAssertNotNil(sut.searchBar.delegate)
    }
    
    func test_searchBar_whenGivenQuery_searchBarTextDidChange() {
        sut.searchBarTextDidChange = { query in
            XCTAssertEqual(query, "query")
        }
        
        sut.searchBar.delegate?.searchBar?(sut.searchBar, textDidChange: "query")
    }
    
    func test_searchBar_searchButtonTapped_setEndEditing() {
        sut.searchBar.delegate?.searchBarSearchButtonClicked?(sut.searchBar)
        XCTAssertFalse(sut.searchBar.isFirstResponder)
    }
    
    func test_searchBar_cancelButtonClicked_setEndEditing() {
        sut.searchBar.delegate?.searchBarCancelButtonClicked?(sut.searchBar)
        XCTAssertFalse(sut.searchBar.isFirstResponder)
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
    
    func test_tableView_whenViewModelEmpty_setNumberOfRowsInSection() {
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }
    
    func test_tableView_givenViewModel_setNumberOfRowsInSection() {
        sut.filteredViewModels = [whenGetGenreViewModel(), whenGetGenreViewModel(), whenGetGenreViewModel()]
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 3)
    }
    
    func test_tableView_givenViewModel_setCellForRow() {
        sut.filteredViewModels = [whenGetGenreViewModel(), whenGetGenreViewModel()]
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "Action")
    }
    
    func test_tableView_givenViewModel_setCellBackgroundColor() {
        sut.filteredViewModels = [whenGetGenreViewModel(), whenGetGenreViewModel()]
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_tableView_givenViewModel_setCellSelectionStyle() {
        sut.filteredViewModels = [whenGetGenreViewModel(), whenGetGenreViewModel()]
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.selectionStyle, UITableViewCell.SelectionStyle.none)
    }
    
    func test_tableView_givenViewModel_setCellLabelFont() {
        sut.filteredViewModels = [whenGetGenreViewModel(), whenGetGenreViewModel()]
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.font, StyleConstants.Font.body)
    }
    
    func test_tableView_setDidSelect() {
        sut.filteredViewModels = [whenGetGenreViewModel(name: "Test1", ids: [1]), whenGetGenreViewModel()]
        sut.genreSelected = { genre in
            XCTAssertEqual(genre.name, "Test1")
        }
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func test_searchBarAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.searchBar.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_searchBarAppearance_setIsTransclucent() {
        XCTAssertEqual(sut.searchBar.isTranslucent, true)
    }
    
    func test_searchBarAppearance_setSearchBarStyle() {
        XCTAssertEqual(sut.searchBar.searchBarStyle, .prominent)
    }
    
    func test_searchBarAppearance_setPlaceholder() {
        XCTAssertEqual(sut.searchBar.placeholder, TextConstants.searchPlaceholder)
    }
    
    func test_searchBarAppearance_setShowsCancelButton() {
        XCTAssertEqual(sut.searchBar.showsCancelButton, true)
    }
    
    func test_searchBarAppearance_setReturnType() {
        XCTAssertEqual(sut.searchBar.returnKeyType, .search)
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
        sut.filteredViewModels = [whenGetGenreViewModel(name: "TestChange", ids: [1]), whenGetGenreViewModel()]
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "TestChange")
    }
    

}
