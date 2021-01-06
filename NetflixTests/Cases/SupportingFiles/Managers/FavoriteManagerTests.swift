//
//  FavoriteManagerTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class FavoriteManagerTests: XCTestCase {

    var sut: FavoriteManager!
    var userDefaults: FakeUserDefaults!
    
    override func setUp() {
        super.setUp()
        userDefaults = FakeUserDefaults()
        sut = FavoriteManager()
        sut.userDefaults = userDefaults
    }
    
    override func tearDown() {
        sut = nil
        userDefaults = nil
        super.tearDown()
    }
    
    func test_favoriteManager_whenGivenFavorite_setLocale() {
        sut.favorites = [TitleDetail.dummy]
        sut.setLocale()
        XCTAssertNotNil(userDefaults.dataDict[UserDefaultsKeyConstants.favorites])
    }
    
    func test_favoriteManager_whenEmptyFavorite_setLocale() {
        sut.favorites = []
        sut.setLocale()
        XCTAssertNotNil(userDefaults.dataDict[UserDefaultsKeyConstants.favorites])
    }
    
    func test_favoriteManager_whenEmptyFavorite_getLocale() {
        let favorites = sut.getLocale()
        XCTAssertTrue(favorites.isEmpty)
    }
    
    func test_favoriteManager_given1Favorite_getLocale() {
        sut.favorites = [TitleDetail.dummy]
        sut.setLocale()
        let favorites = sut.getLocale()
        XCTAssertEqual(favorites.count, 1)
    }
    
    func test_favoriteManager_given2Favorites_getLocale() {
        sut.favorites = [TitleDetail.dummy, TitleDetail.dummy]
        sut.setLocale()
        let favorites = sut.getLocale()
        XCTAssertEqual(favorites.count, 2)
    }
    
    func test_favoriteManager_whenFavoritesEmpty_getFavorites() {
        XCTAssertTrue(sut.favorites.isEmpty)
    }
    
    func test_favoriteManager_whenGivenFavorite_getFavorites() {
        sut.favorites = [TitleDetail.dummy]
        sut.setLocale()
        sut.getFavorites()
        XCTAssertEqual(sut.favorites.count, 1)
    }
    
    func test_favoriteManager_whenGiven2Favorites_getFavorites() {
        sut.favorites = [TitleDetail.dummy, TitleDetail.dummy]
        sut.setLocale()
        sut.getFavorites()
        XCTAssertEqual(sut.favorites.count, 2)
    }
    
    func test_favoriteManager_favoriteAction_whenGivenSearchResult_setFavorites() {
        sut.favoriteAction(result: SearchResult.dummy)
        XCTAssertFalse(sut.favorites.isEmpty)
    }
    
    func test_favoriteManager_favoriteAction_whenGivenTitleDetail_setFavorites() {
        sut.favoriteAction(titleDetail: TitleDetail.dummy)
        XCTAssertFalse(sut.favorites.isEmpty)
    }
    
    func test_favoriteManager_favoriteAction_whenCalled2Times_setFavorites() {
        sut.favoriteAction(result: SearchResult.dummy)
        sut.favoriteAction(result: SearchResult.dummy)
        XCTAssertTrue(sut.favorites.isEmpty)
    }
    
}
