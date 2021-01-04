//
//  ResultCategoryViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class ResultCategoryViewTests: XCTestCase {

    var sut: ResultCategoryView!
    
    override func setUp() {
        super.setUp()
        whenSUTSetFromGenreViewModels()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetViewModelSetFromGenre(name: String,
                                   ids: [Int]? = nil) -> GenreViewModel {
        return GenreViewModel(genre: Genre(name: name, ids: ids))
    }
    
    func whenSUTSetFromGenreViewModels(viewModels: [GenreViewModel] = []) {
        sut = ResultCategoryView(viewModels: viewModels)
    }
    
    func test_initResultCategory_whenViewModelEmpty_setViewModels() {
        XCTAssertTrue(sut.viewModels.isEmpty)
    }
    
    func test_initResultCategory_whenGivenViewModel_setViewModels() {
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Test", ids: [1])])
        XCTAssertFalse(sut.viewModels.isEmpty)
    }
    
    func test_initResultCategory_whenGiven2ViewModels_setViewModels() {
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Test", ids: [1]), whenSetViewModelSetFromGenre(name: "Test2", ids: [1, 2])])
        XCTAssertEqual(sut.viewModels.count, 2)
    }
    
    func test_initResultCategory_setBackgroundColor() {
        XCTAssertEqual(sut.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_initResultCategory_whenInitCoder() {
        sut = ResultCategoryView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_initResultCategory_setCollectionView() {
        XCTAssertTrue(sut.subviews.contains(sut.collectionView))
    }
    
    func test_collectionView_givenViewModel_setHeightConstraint() {
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Genre Long 1"), whenSetViewModelSetFromGenre(name: "Genre Long 2"), whenSetViewModelSetFromGenre(name: "Genre Long 3"), whenSetViewModelSetFromGenre(name: "Genre Long 4"), whenSetViewModelSetFromGenre(name: "Genre Long 5")])
        XCTAssertEqual(sut.heightConstraint?.constant, sut.collectionView.contentSize.height)
        
    }
    
    func test_collectionView_whenViewModelsDidChange_setHeightConstraint() {
        sut.viewModels = [whenSetViewModelSetFromGenre(name: "Genre Long 1"), whenSetViewModelSetFromGenre(name: "Genre Long 2"), whenSetViewModelSetFromGenre(name: "Genre Long 3"), whenSetViewModelSetFromGenre(name: "Genre Long 4"), whenSetViewModelSetFromGenre(name: "Genre Long 5")]
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
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Genre Long 1"), whenSetViewModelSetFromGenre(name: "Genre Long 2")])
        XCTAssertEqual(sut.collectionView.dataSource?.collectionView(sut.collectionView, numberOfItemsInSection: 0), 2)
    }
    
    func test_collectionView_cellForRow() {
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Genre Long 1"), whenSetViewModelSetFromGenre(name: "Genre Long 2")])
        let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! ResultCategoryCollectionViewCell
        XCTAssertEqual(cell.label.text, "Genre Long 1")
    }
    
    func test_collectionView_setDidSelect() {
        sut.genreSelected = { viewModel in
            XCTAssertEqual(viewModel.nameText, "Genre Long 1")
        }
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Genre Long 1"), whenSetViewModelSetFromGenre(name: "Genre Long 2")])
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
    
    func test_collectionView_setItemHeight() {
        whenSUTSetFromGenreViewModels(viewModels: [whenSetViewModelSetFromGenre(name: "Genre Long 1")])
        XCTAssertEqual(sut.collectionView(sut.collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0)).height, 30.0)
    }

    func test_collectionViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.collectionView.backgroundColor, StyleConstants.Color.lightGray)
    }
    
    func test_collectionViewAppearance_setKeyboardDismissMode() {
        XCTAssertEqual(sut.collectionView.keyboardDismissMode, .onDrag)
    }
    
    func test_collectionViewAppearance_setShowsVerticalScrollIndicator() {
        XCTAssertFalse(sut.collectionView.showsVerticalScrollIndicator)
    }
    
    func test_collectionViewAppearance_setShowsHorizontalScrollIndicator() {
        XCTAssertFalse(sut.collectionView.showsHorizontalScrollIndicator)
    }
    
}
