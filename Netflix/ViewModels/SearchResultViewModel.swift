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
         
            if let urlString = searchResult.image {
                return URL(string: urlString)
            }
            
            if let urlString = searchResult.image1 {
                return URL(string: urlString)
            }
            
            if let urlString = searchResult.image2 {
                return URL(string: urlString)
            }
            
            return nil
        }

        if let urlString = searchResult.largeimage {
            return URL(string: urlString)
        }
        
        if let urlString = searchResult.image1 {
            return URL(string: urlString)
        }
        
        if let urlString = searchResult.image2 {
            return URL(string: urlString)
        }
        
        return nil
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
