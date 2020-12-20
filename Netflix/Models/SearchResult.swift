//
//  SearchResult.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import Foundation

struct SearchResultResponse: Codable {
    let count: String?
    let items: [SearchResult]?
    
    enum CodingKeys: String, CodingKey {
        case count = "COUNT"
        case items = "ITEMS"
    }
}

struct SearchResult: Codable {
    let netflixid, title: String?
    let image: String?
    let synopsis, rating: String?
    let type: String?
    let released, runtime: String?
    let largeimage: String?
    let unogsdate, imdbid, download: String?
}
