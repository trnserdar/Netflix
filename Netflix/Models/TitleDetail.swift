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
    
    var genres: [Genre] {
        get {
            guard let mgName = mgname,
                  !mgName.isEmpty,
                  let genreId = genreid,
                  !genreId.isEmpty,
                  mgName.count == genreId.count else {
                return []
            }
            
            var tmpGenres: [Genre] = []
            for index in 0..<mgName.count {
                tmpGenres.append(Genre(name: mgName[index], ids: [Int(genreId[index]) ?? 0]))
            }
            
            return tmpGenres
        }
    }

    enum CodingKeys: String, CodingKey {
        case nfinfo, imdbinfo, mgname
        case genreid = "Genreid"
        case people, country
    }
    
    static let dummy = TitleDetail(nfinfo: Nfinfo.dummy, imdbinfo: Imdbinfo.dummy, mgname: ["TV Comedies", "US TV Programmes", "TV Programmes", "Sitcoms"], genreid: ["10375", "72404", "83", "3903"], people: [Person(actor: [
        "Joe Lo Truglio", "Terry Crews", "Melissa Fumero", "Andy Samberg", "Stephanie Beatriz", "Andre Braugher", "Dirk Blocker", "Joel McKinnon Miller", "Chelsea Peretti"], creator: ["Daniel J. Goor", "Michael Schur"], director: nil)], country: nil)
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
    let votes, imdbvotes, totalseasons, tomatoFresh, released: String?
    let awards, type, language, rating, runtime: String?
    let plot, rated, tomatoReviews, tomatoMeter: String?
    let filmid, newid, tomatoRating, imdbid: String?
    let localimage, tomatoUserRating, top250, imdbtitle: String?
    let country, tomatoUserMeter, top250Tv, tomatoRotten: String?
    let imdbrating: String?

    enum CodingKeys: String, CodingKey {
        case date, production, tomatoConsensus, rating, tomatoUserReviews, metascore, genre, poster, votes, imdbvotes, totalseasons, tomatoFresh, released, awards, type, language, runtime, plot, rated, tomatoReviews, tomatoMeter, filmid, newid, tomatoRating, imdbid, localimage, tomatoUserRating, top250, imdbtitle, country, tomatoUserMeter
        case top250Tv = "top250tv"
        case tomatoRotten, imdbrating
    }
    
    static let dummy = Imdbinfo(date: nil, production: nil, tomatoConsensus: nil, tomatoUserReviews: nil, metascore: "N/A", genre: "Comedy, Crime", poster: nil, votes: nil, imdbvotes: nil, totalseasons: nil, tomatoFresh: nil, released: nil, awards: "Won 2 Golden Globes. Another 10 wins & 96 nominations.", type: nil, language: "English", rating: "8.4", runtime: "22 min", plot: "Captain Ray Holt (Andre Braugher) takes over Brooklyn&amp;#39;s 99th precinct, which includes Detective Jake Peralta (Andy Samberg), a talented but carefree detective who&amp;#39;s used to doing whatever he wants. The other employees of the 99th precinct include Detective Amy Santiago (Melissa Fumero), Jake&amp;#39;s over achieving and competitive partner; Detective Rosa Diaz (Stephanie Beatriz), a tough and kept to herself coworker; Detective Charles Boyle (Joe Lo Truglio), Jake&amp;#39;s best friend who also has crush on Rosa; Detective Sergeant Terry Jeffords (Terry Crews), was recently taken off the field after the birth of his twin girls; and Gina Linetti (Chelsea Peretti), the precinct&amp;#39;s sarcastic administrator.", rated: nil, tomatoReviews: nil, tomatoMeter: nil, filmid: nil, newid: nil, tomatoRating: nil, imdbid: "tt2467372", localimage: nil, tomatoUserRating: nil, top250: nil, imdbtitle: nil, country: "USA", tomatoUserMeter: nil, top250Tv: nil, tomatoRotten: nil, imdbrating: nil)
}

struct Nfinfo: Codable {
    let image1: String?
    let title, synopsis, matlevel, matlabel: String?
    let avgrating, type, updated, unogsdate: String?
    let released, netflixid, runtime: String?
    let image2: String?
    let download: String?
    
    static let dummy = Nfinfo(image1: "https://occ-0-56-55.1.nflxso.net/dnm/api/v6/evlCitJPPCVCry0BZlEFb5-QjKc/AAAABd9TdKMfNuWIKStxtms90uVk1PUjcIvcPsVz3qqKFUnYYifF0w5XYg44hIzgJw9kf0aN-k-BaI-_fE3YadaHl9hlz7b3.jpg?r=8e9", title: "Brooklyn Nine-Nine", synopsis: "This ensemble comedy tracks the characters and cases of a Brooklyn police station, far from the dangerous and dramatic challenges of Manhattan.", matlevel: "50", matlabel: "Suitable for 12 years and over", avgrating: "4.4845767", type: "series", updated: "2020-12-19 11:42:49", unogsdate: "2015-04-14 13:17:22", released: "2013", netflixid: "70281562", runtime: "na", image2: "https://occ-0-56-55.1.nflxso.net/dnm/api/v6/evlCitJPPCVCry0BZlEFb5-QjKc/AAAABd9TdKMfNuWIKStxtms90uVk1PUjcIvcPsVz3qqKFUnYYifF0w5XYg44hIzgJw9kf0aN-k-BaI-_fE3YadaHl9hlz7b3.jpg?r=8e9", download: "1")
}

// MARK: - Person
struct Person: Codable {
    let actor, creator, director: [String]?
}
