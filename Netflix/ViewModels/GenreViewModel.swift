//
//  GenreViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import Foundation
import UIKit

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
    
    var itemWidth: CGFloat {
        return textWidth(font: StyleConstants.Font.body!, text: nameText) + 16
    }
    
    var itemHeight: CGFloat {
        return 30.0
    }
    
    func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}
