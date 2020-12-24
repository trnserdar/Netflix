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
    var sizeOption: SizeOption
    
    init(searchResult: SearchResult, sizeOption: SizeOption = .small) {
        self.searchResult = searchResult
        self.sizeOption = sizeOption
    }
    
    var itemWidth: CGFloat {
        
        if sizeOption == .small {
            return (UIScreen.main.bounds.width - 48) / 2
        }
        
        return 284
    }
    
    var itemHeight: CGFloat {
        
        if sizeOption == .small {
            return (itemWidth * 233) / 166
        }
        
        return 398
    }
    
    var imageURL: URL? {
        
        if sizeOption == .small {
         
            guard let urlString = searchResult.image else {
                return nil
            }
            
            return URL(string: urlString)
        }

        guard let urlString = searchResult.largeimage else {
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
