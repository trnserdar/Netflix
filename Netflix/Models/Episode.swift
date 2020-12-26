//
//  Episode.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import Foundation

struct EpisodeResponse: Codable {
    let results: [EpisodeResult]?

    enum CodingKeys: String, CodingKey {
        case results = "RESULTS"
    }
}

struct EpisodeResult: Codable, Equatable {
    let seasid, seasnum, country: String?
    let episodes: [EpisodeElement]?
    
    static func == (lhs: EpisodeResult, rhs: EpisodeResult) -> Bool {
        return lhs.seasid == rhs.seasid &&
            lhs.seasnum == rhs.seasnum &&
            lhs.country == rhs.country &&
            lhs.episodes == rhs.episodes
    }
}

struct EpisodeElement: Codable, Equatable {
    let episode: Episode?
    
    static func == (lhs: EpisodeElement, rhs: EpisodeElement) -> Bool {
        return lhs.episode == rhs.episode
    }
}

struct Episode: Codable, Equatable {
    let id, seasnum, epnum, title: String?
    let image: String?
    let synopsis, available: String?
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id &&
            lhs.seasnum == rhs.seasnum &&
            lhs.epnum == rhs.epnum &&
            lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.synopsis == rhs.synopsis &&
            lhs.available == rhs.available
    }
}
