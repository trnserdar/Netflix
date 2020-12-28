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
    var favorites: [TitleDetail]
    
    init(searchResult: SearchResult, sizeOption: SizeOption = .small, favorites: [TitleDetail]) {
        self.searchResult = searchResult
        self.sizeOption = sizeOption
        self.favorites = favorites
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
    
    var favoriteButtonImage: UIImage? {
        
        guard favorites.contains(where: { $0.nfinfo?.netflixid == searchResult.netflixid }) else {
            return StyleConstants.Image.heart
        }
        
        return StyleConstants.Image.heartFill
    }
}
