//
//  SearchResulting.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation

protocol SearchResulting: AnyObject {
    func showResult(selectedGenre: Genre?, results: [SearchResult])
}
