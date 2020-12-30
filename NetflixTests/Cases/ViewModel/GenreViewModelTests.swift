//
//  GenreViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 30.12.2020.
//

import XCTest
@testable import Netflix

class GenreViewModelTests: XCTestCase {

    var sut: GenreViewModel!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromGenre()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSUTSetFromGenre(name: String = "Action",
                             ids: [Int]? = [801362]) {
        
        let genre = Genre(name: name,
                          ids: ids)
        sut = GenreViewModel(genre: genre)
    }
    
    func test_initGenre_setName() {
        XCTAssertEqual(sut.nameText, "Action")
    }
    
    func test_initGenre_setSelectedId() {
        XCTAssertEqual(sut.selectedId, "801362")
    }
    
    func test_initGenre_whenIdsEmpty_setSelectedId() {
        whenSUTSetFromGenre(ids: nil)
        XCTAssertEqual(sut.selectedId, "0")
    }
    
    func test_initGenre_setItemHeight() {
        XCTAssertEqual(sut.itemHeight, 30.0)
    }
    
    func test_initGenre_setItemWidth() {
        XCTAssertEqual(sut.itemWidth, 56.0)
    }
    
}
