//
//  FavoriteManager.swift
//  Netflix
//
//  Created by SERDAR TURAN on 28.12.2020.
//

import Foundation

protocol FavoriteManagerProtocol {
    func getFavorites()
    func favoriteAction(result: SearchResult)
    func favoriteAction(titleDetail: TitleDetail)
    var favorites: [TitleDetail] { get set }
    var favoritesChanged: (([TitleDetail]) -> Void)? { get set }
}

final class FavoriteManager: FavoriteManagerProtocol {
    
    var userDefaults = UserDefaults.standard
    var favorites: [TitleDetail] = [] {
        didSet {
            favoritesChanged?(favorites)
            setLocale()
        }
    }

    var favoritesChanged: (([TitleDetail]) -> Void)?
    
    func getFavorites() {
        print("FavoriteManager -> getFavorites")
        self.favorites = getLocale()
    }
    
    func favoriteAction(result: SearchResult) {
        self.favoriteAction(titleDetail: TitleDetail(nfinfo: result, imdbinfo: nil, mgname: nil, genreid: nil, people: nil, country: nil))
    }
    
    func favoriteAction(titleDetail: TitleDetail) {
        guard let netflixInfo = titleDetail.nfinfo,
              let netflixId = netflixInfo.netflixid,
              let index = favorites.firstIndex(where: { $0.nfinfo?.netflixid == netflixId }) else {
            print("FavoriteManager -> addFavorite: \(titleDetail.nfinfo?.netflixid ?? "")")
            favorites.append(titleDetail)
            return
        }
        
        print("FavoriteManager -> deleteFavorite: \(titleDetail.nfinfo?.netflixid ?? "")")
        favorites.remove(at: index)
    }
    
    func getLocale() -> [TitleDetail] {
        guard let favoritesData = userDefaults.data(forKey: UserDefaultsKeyConstants.favorites),
              let favorites = try? JSONDecoder().decode([TitleDetail].self, from: favoritesData) else {
            return []
        }
        
        return favorites
    }
    
    func setLocale() {
        guard let encoded = try? JSONEncoder().encode(favorites) else {
            return
        }

        userDefaults.setValue(encoded, forKey: UserDefaultsKeyConstants.favorites)
        userDefaults.synchronize()
        
    }
    
}
