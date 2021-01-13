//
//  MockFavoriteManager.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class MockFavoriteManager: FavoriteManagerProtocol {
    
    var favorites: [TitleDetail] = []
    var favoritesChanged: (([TitleDetail]) -> Void)?
    var getFavoritesCount = 0
    var favoriteActionCount = 0
    var favoriteActionWithTitleDetailCount = 0
    
    func getFavorites() {
        getFavoritesCount += 1
    }
    
    func favoriteAction(result: SearchResult) {
        favoriteActionCount += 1
    }
    
    func favoriteAction(titleDetail: TitleDetail) {
        favoriteActionWithTitleDetailCount += 1
    }

}
