//
//  SearchResultViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import Foundation
import UIKit

struct SearchResultViewModel {
    
    var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    var itemWidth: CGFloat {
        return (UIScreen.main.bounds.width - 48) / 2
    }
    
    var itemHeight: CGFloat {
        return (itemWidth * 233) / 166
    }
    
    var imageURL: URL? {
        
        guard let urlString = searchResult.image else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    var ratingIsHidden: Bool {
        
        guard ratingText != "" else {
            return true
        }
        
        return false
    }
    
    var ratingText: String {
        return searchResult.rating ?? ""
    }
}
