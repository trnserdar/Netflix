//
//  CastViewModelTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 31.12.2020.
//

import XCTest
@testable import Netflix

class CastViewModelTests: XCTestCase {

    var sut: CastViewModel!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromPerson()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func whenSUTSetFromPerson(actor: [String]? = ["actor"],
                              creator: [String]? = ["creator"],
                              director: [String]? = ["director"]) {
        
        let person = Person(actor: actor, creator: creator, director: director)
        sut = CastViewModel(person: person)
    }
    
    func test_initPerson_setSectionCount() {
        XCTAssertEqual(sut.sectionCount, 3)
    }
    
    func test_initPerson_whenSection0_setRowCount() {
        let rowCount = sut.getRowCount(section: 0)
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_initPerson_whenSection0AndDirectorEmpty_setRowCount() {
        whenSUTSetFromPerson(director: nil)
        let rowCount = sut.getRowCount(section: 0)
        XCTAssertEqual(rowCount, 0)
    }
    
    func test_initPerson_whenSection1_setRowCount() {
        let rowCount = sut.getRowCount(section: 1)
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_initPerson_whenSection1AndCreatorEmpty_setRowCount() {
        whenSUTSetFromPerson(creator: nil)
        let rowCount = sut.getRowCount(section: 1)
        XCTAssertEqual(rowCount, 0)
    }

    func test_initPerson_whenSection2_setRowCount() {
        let rowCount = sut.getRowCount(section: 2)
        XCTAssertEqual(rowCount, 1)
    }
    
    func test_initPerson_whenSection2AndActorEmpty_setRowCount() {
        whenSUTSetFromPerson(actor: nil)
        let rowCount = sut.getRowCount(section: 2)
        XCTAssertEqual(rowCount, 0)
    }
    
    func test_initPerson_whenSection3_setRowCount() {
        let rowCount = sut.getRowCount(section: 3)
        XCTAssertEqual(rowCount, 0)
    }
    
    func test_initPerson_whenSection0AndRow0_setPerson() {
        let person = sut.getPerson(section: 0, row: 0)
        XCTAssertEqual(person, "director")
    }
    
    func test_initPerson_whenSection0AndRow1_setPerson() {
        let person = sut.getPerson(section: 0, row: 1)
        XCTAssertEqual(person, "")
    }
    
    func test_initPerson_whenSection1AndRow0_setPerson() {
        let person = sut.getPerson(section: 1, row: 0)
        XCTAssertEqual(person, "creator")
    }
    
    func test_initPerson_whenSection1AndRow1_setPerson() {
        let person = sut.getPerson(section: 1, row: 1)
        XCTAssertEqual(person, "")
    }
    
    func test_initPerson_whenSection2AndRow0_setPerson() {
        let person = sut.getPerson(section: 2, row: 0)
        XCTAssertEqual(person, "actor")
    }
    
    func test_initPerson_whenSection2AndRow1_setPerson() {
        let person = sut.getPerson(section: 2, row: 1)
        XCTAssertEqual(person, "")
    }

    func test_initPerson_whenSection3_setPerson() {
        let person = sut.getPerson(section: 3, row: 1)
        XCTAssertEqual(person, "")
    }
    
    func test_initPerson_whenSection0_setTitle() {
        let title = sut.getTitle(section: 0)
        XCTAssertEqual(title, TextConstants.director)
    }
    
    func test_initPerson_whenSection1_setTitle() {
        let title = sut.getTitle(section: 1)
        XCTAssertEqual(title, TextConstants.creator)
    }
    
    func test_initPerson_whenSection2_setTitle() {
        let title = sut.getTitle(section: 2)
        XCTAssertEqual(title, TextConstants.actor)
    }
    
    func test_initPerson_whenSection3_setTitle() {
        let title = sut.getTitle(section: 3)
        XCTAssertEqual(title, "")
    }
}
