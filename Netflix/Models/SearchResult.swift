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

struct SearchResult: Codable, Equatable {
    let netflixid, title: String?
    let image: String?
    let synopsis, rating: String?
    let type: String?
    let released, runtime: String?
    let largeimage: String?
    let unogsdate, imdbid, download: String?
    
    static let dummy = SearchResult(netflixid: "81393502", title: "The Netflix Afterparty: The Best Shows of The Worst Year", image: "https://occ-0-70-1722.1.nflxso.net/dnm/api/v6/evlCitJPPCVCry0BZlEFb5-QjKc/AAAABfPuGHNTkJg2WD8laLv1uydXGE9PhgmA5z2BLwTUpplVnEiPbabWJswuaDYiHechuuTqzXKKBsj7Hl-iWgptPffEU2EPAUUfxiJTn_KlXz13vuv3THRxSAeMSiY.jpg?r=f4f", synopsis: "David Spade, Fortune Feimster and London Hughes welcome guests from &quot;Tiger King,&quot; &quot;Emily in Paris,&quot; &quot;The Queen&#39;s Gambit&quot; and more. Plus: Kevin Hart.<br><b>New on 2020-12-14</b>", rating: "6.0", type: "movie", released: "2020", runtime: "59m", largeimage: "https://occ-0-36-2568.1.nflxso.net/dnm/api/v6/evlCitJPPCVCry0BZlEFb5-QjKc/AAAABXrL-Kb2rtDdNFENdNsoHtpGgusfRernbo87LIGM-UApmi0kfVHIINQgcmaF16NFWfpPL--QaXvEbKh7qsD8qKSpdv9mkABdCCwg41U9EsASOVnF4aGygXZmCSrmnQ.jpg?r=f4f", unogsdate: "2020-12-14", imdbid: "", download: "0")
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.netflixid == rhs.netflixid &&
            lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.synopsis == rhs.synopsis &&
            lhs.rating == rhs.rating &&
            lhs.type == rhs.type &&
            lhs.released == rhs.released &&
            lhs.runtime == rhs.runtime &&
            lhs.largeimage == rhs.largeimage &&
            lhs.unogsdate == rhs.unogsdate &&
            lhs.imdbid == rhs.imdbid &&
            lhs.download == rhs.download
    }
}
