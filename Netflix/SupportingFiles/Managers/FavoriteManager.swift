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

protocol UserDefaultsProtocol {
    func data(forKey defaultName: String) -> Data?
    func setValue(_ value: Any?, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsProtocol { }

final class FavoriteManager: FavoriteManagerProtocol {
    
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    var favorites: [TitleDetail] = [] {
        didSet {
            favoritesChanged?(favorites)
            setLocale()
        }
    }

    var favoritesChanged: (([TitleDetail]) -> Void)?
    
    func getFavorites() {
        self.favorites = getLocale()
    }
    
    func favoriteAction(result: SearchResult) {
        self.favoriteAction(titleDetail: TitleDetail(nfinfo: result, imdbinfo: nil, mgname: nil, genreid: nil, people: nil, country: nil))
    }
    
    func favoriteAction(titleDetail: TitleDetail) {
        guard let netflixInfo = titleDetail.nfinfo,
              let netflixId = netflixInfo.netflixid,
              let index = favorites.firstIndex(where: { $0.nfinfo?.netflixid == netflixId }) else {
            favorites.append(titleDetail)
            return
        }
        
        favorites.remove(at: index)
    }
    
    func getLocale() -> [TitleDetail] {
        guard let favoritesData = userDefaults.data(forKey: UserDefaultsKeyConstants.favorites),
              let favorites = try? JSONDecoder().decode([TitleDetail].self, from: favoritesData),
              !favorites.isEmpty else {
            return []
        }
        
        return favorites
    }
    
    func setLocale() {
        guard let encoded = try? JSONEncoder().encode(favorites) else {
            return
        }

        userDefaults.setValue(encoded, forKey: UserDefaultsKeyConstants.favorites)
    }
    
}
