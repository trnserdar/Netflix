//
//  MockNetflixClient.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 7.01.2021.
//

import XCTest
@testable import Netflix
import Alamofire

class MockNetflixClient: NetflixClientProtocol {

    var genresCount = 0
    var genresCompletion: (([Genre]?, Error?) -> Void)!

    var searchCount = 0
    var searchCompletion: (([SearchResult]?, Error?) -> Void)!
    
    var titleDetailCount = 0
    var titleDetailCompletion: ((TitleDetail?, Error?) -> Void)!
    
    var episodeDetailCount = 0
    var episodeDetailCompletion: (([EpisodeResult]?, Error?) -> Void)!
    
    var newReleasesCount = 0
    var newReleasesCompletion: (([SearchResult]?, Error?) -> Void)!
    
    var imagesCount = 0
    var imagesCompletion: (([ImageResult]?, Error?) -> Void)!
    
    var imdbDetailCount = 0
    var imdbDetailCompletion: ((Imdbinfo?, Error?) -> Void)!
    
    func getGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        genresCount += 1
        genresCompletion = completion
    }
    
    func search(query: String, genreId: String, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        searchCount += 1
        searchCompletion = completion
    }
    
    func titleDetail(netflixId: String, completion: @escaping (TitleDetail?, Error?) -> Void) {
        titleDetailCount += 1
        titleDetailCompletion = completion
    }
    
    func episodeDetail(netflixId: String, completion: @escaping ([EpisodeResult]?, Error?) -> Void) {
        episodeDetailCount += 1
        episodeDetailCompletion = completion
    }
    
    func newReleases(days: String, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        newReleasesCount += 1
        newReleasesCompletion = completion
    }
    
    func images(netflixId: String, completion: @escaping ([ImageResult]?, Error?) -> Void) {
        imagesCount += 1
        imagesCompletion = completion
    }
    
    func imdbDetail(netflixId: String, completion: @escaping (Imdbinfo?, Error?) -> Void) {
        imdbDetailCount += 1
        imdbDetailCompletion = completion
    }
    
}
