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

struct EpisodeResult: Codable {
    let seasid, seasnum, country: String?
    let episodes: [EpisodeElement]?
}

struct EpisodeElement: Codable {
    let episode: Episode?
}

struct Episode: Codable {
    let id, seasnum, epnum, title: String?
    let image: String?
    let synopsis, available: String?
}
