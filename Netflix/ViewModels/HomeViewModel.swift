//
//  HomeViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import Foundation

struct HomeViewModel {
    
    var newRelease: CategoryViewModel
    var action: CategoryViewModel

    init(newRelease: CategoryViewModel = CategoryViewModel(categoryName: TextConstants.newReleases, searchResults: [], sizeOption: .big, favorites: []), action: CategoryViewModel = CategoryViewModel(categoryName: TextConstants.crimeActionAdventure, searchResults: [], sizeOption: .small, favorites: [])) {
        self.newRelease = newRelease
        self.action = action
    }
    
}
