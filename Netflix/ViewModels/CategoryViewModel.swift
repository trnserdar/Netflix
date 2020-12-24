//
//  CategoryViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import Foundation

enum SizeOption {
    case small
    case normal
    case big
}

struct CategoryViewModel {
    
    var categoryName: String
    var searchResults: [SearchResult]
    var sizeOption: SizeOption
    
    init(categoryName: String, searchResults: [SearchResult], sizeOption: SizeOption = .small) {
        self.categoryName = categoryName
        self.searchResults = searchResults
        self.sizeOption = sizeOption
    }

    
}
