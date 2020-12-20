//
//  TitleDetail.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import Foundation

struct TitleDetailResponse: Codable {
    let result: TitleDetail?

    enum CodingKeys: String, CodingKey {
        case result = "RESULT"
    }
}

struct TitleDetail: Codable {
    let nfinfo: Nfinfo?
    let imdbinfo: Imdbinfo?
    let mgname, genreid: [String]?
    let people: [Person]?
    let country: [Country]?

    enum CodingKeys: String, CodingKey {
        case nfinfo, imdbinfo, mgname
        case genreid = "Genreid"
        case people, country
    }
}

struct Country: Codable {
    let country, ccode: String?
    let seasons: String?
    let new, expires: String?
    let seasondet: [String]?
    let audio: [String]?
    let subs: [String]?
    let cid: String?
    let islive: String?
}

struct Imdbinfo: Codable {
    let date, production, tomatoConsensus, tomatoUserReviews: String?
    let metascore, genre: String?
    let poster: String?
    let imdbvotes, totalseasons, tomatoFresh, released: String?
    let awards, type, language, runtime: String?
    let plot, rated, tomatoReviews, tomatoMeter: String?
    let filmid, newid, tomatoRating, imdbid: String?
    let localimage, tomatoUserRating, top250, imdbtitle: String?
    let country, tomatoUserMeter, top250Tv, tomatoRotten: String?
    let imdbrating: String?

    enum CodingKeys: String, CodingKey {
        case date, production, tomatoConsensus, tomatoUserReviews, metascore, genre, poster, imdbvotes, totalseasons, tomatoFresh, released, awards, type, language, runtime, plot, rated, tomatoReviews, tomatoMeter, filmid, newid, tomatoRating, imdbid, localimage, tomatoUserRating, top250, imdbtitle, country, tomatoUserMeter
        case top250Tv = "top250tv"
        case tomatoRotten, imdbrating
    }
}

struct Nfinfo: Codable {
    let image1: String?
    let title, synopsis, matlevel, matlabel: String?
    let avgrating, type, updated, unogsdate: String?
    let released, netflixid, runtime: String?
    let image2: String?
    let download: String?
}

// MARK: - Person
struct Person: Codable {
    let actor, creator, director: [String]?
}
