//
//  GenreViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import Foundation

struct GenreViewModel {
    
    var genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var nameText: String {
        return genre.name
    }
    
    var selectedId: String {
        return "\(genre.ids?.first ?? 0)"
    }
}
