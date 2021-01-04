//
//  ResultCategoryCollectionViewCellTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class ResultCategoryCollectionViewCellTests: XCTestCase {

    var sut: ResultCategoryCollectionViewCell!

    override func setUp() {
        super.setUp()
        sut = ResultCategoryCollectionViewCell()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetViewModelSetFromGenre(name: String,
                                   ids: [Int]? = nil) -> GenreViewModel {
        return GenreViewModel(genre: Genre(name: name, ids: ids))
    }
    
    func test_initResultCategoryCell_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initResultCategoryCell_setLabel() {
        XCTAssertTrue(sut.subviews.contains(sut.label))
    }
        
    func test_initResultCategoryCell_initWithCoder() {
        sut = ResultCategoryCollectionViewCell(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_labelAppearance_setFont() {
        XCTAssertEqual(sut.label.font, StyleConstants.Font.body)
    }
    
    func test_labelAppearance_setTextAlignment() {
        XCTAssertEqual(sut.label.textAlignment, .center)
    }

    func test_labelAppearance_setBorderWidth() {
        XCTAssertEqual(sut.label.layer.borderWidth, 1.0)
    }

    func test_labelAppearance_setBorderColor() {
        XCTAssertEqual(sut.label.layer.borderColor, StyleConstants.Color.gray?.cgColor)
    }

    func test_labelAppearance_setCornerRadius() {
        XCTAssertEqual(sut.label.layer.cornerRadius, 15.0)
    }
    
    func test_configureCell_setLabel() {
        sut.configureCell(viewModel: whenSetViewModelSetFromGenre(name: "Test Genre"))
        XCTAssertEqual(sut.label.text, "Test Genre")
    }
    
}
