//
//  NetflixRouterTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 30.12.2020.
//

import XCTest
@testable import Netflix

class NetflixRouterTests: XCTestCase {
    
    var genres: NetflixRouter!
    var search: NetflixRouter!
    var titleDetail: NetflixRouter!
    var episodeDetail: NetflixRouter!
    var newReleases: NetflixRouter!
    var images: NetflixRouter!
    var imdbDetail: NetflixRouter!
    
    override func setUp() {
        super.setUp()
        genres = NetflixRouter.genres
        search = NetflixRouter.search(query: "searchQuery", genreId: "1")
        titleDetail = NetflixRouter.titleDetail(id: "12")
        episodeDetail = NetflixRouter.episodeDetail(id: "123")
        newReleases = NetflixRouter.newReleases(days: "7", country: "US")
        images = NetflixRouter.images(id: "1234")
        imdbDetail = NetflixRouter.imdbDetail(id: "12345")
    }
    
    override func tearDown() {
        genres = nil
        search = nil
        titleDetail = nil
        episodeDetail = nil
        newReleases = nil
        images = nil
        imdbDetail = nil
        super.tearDown()
    }
    
    func test_init_setBaseURL() {
        XCTAssertEqual(NetflixRouter.baseURLPath, NetworkConstants.baseURL)
    }
    
    func test_initGenres_setHttpMethod() {
        XCTAssertEqual(genres.method, .get)
    }
    
    func test_initGenres_setPath() {
        XCTAssertEqual(genres.path, "")
    }
    
    func test_initGenres_setParameters() {
        XCTAssertEqual(genres.parameters["t"], "genres")
    }
    
    func test_initGenres_setHeaders() throws {
        let urlRequest = try genres.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, genres.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
    
    func test_initSearch_setHttpMethod() {
        XCTAssertEqual(search.method, .get)
    }
    
    func test_initSearch_setPath() {
        XCTAssertEqual(search.path, "")
    }
    
    func test_initSearch_setParameters() {
        XCTAssertEqual(search.parameters["t"], "ns")
        XCTAssertEqual(search.parameters["cl"], "all")
        XCTAssertEqual(search.parameters["st"], "adv")
        XCTAssertEqual(search.parameters["ob"], "Relevance")
        XCTAssertEqual(search.parameters["p"], "1")
        XCTAssertEqual(search.parameters["sa"], "and")
        XCTAssertEqual(search.parameters["q"], "searchQuery-!1900,2020-!0,5-!0,10-!1-!Any-!Any-!Any-!gt100-!%7Bdownloadable%7D")
    }
    
    func test_initSearch_setHeaders() throws {
        let urlRequest = try search.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, search.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
    
    func test_initTitleDetail_setHttpMethod() {
        XCTAssertEqual(titleDetail.method, .get)
    }
    
    func test_initTitleDetail_setPath() {
        XCTAssertEqual(titleDetail.path, "")
    }
    
    func test_initTitleDetail_setParameters() {
        XCTAssertEqual(titleDetail.parameters["t"], "loadvideo")
        XCTAssertEqual(titleDetail.parameters["q"], "12")
    }
    
    func test_initTitleDetail_setHeaders() throws {
        let urlRequest = try titleDetail.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, titleDetail.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }

    func test_initEpisodeDetail_setHttpMethod() {
        XCTAssertEqual(episodeDetail.method, .get)
    }
    
    func test_initEpisodeDetail_setPath() {
        XCTAssertEqual(episodeDetail.path, "")
    }
    
    func test_initEpisodeDetail_setParameters() {
        XCTAssertEqual(episodeDetail.parameters["t"], "episodes")
        XCTAssertEqual(episodeDetail.parameters["q"], "123")
    }
    
    func test_initEpisodeDetail_setHeaders() throws {
        let urlRequest = try episodeDetail.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, episodeDetail.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
    
    func test_initNewReleases_setHttpMethod() {
        XCTAssertEqual(newReleases.method, .get)
    }
    
    func test_initNewReleases_setPath() {
        XCTAssertEqual(newReleases.path, "")
    }
    
    func test_initNewReleases_setParameters() {
        XCTAssertEqual(newReleases.parameters["st"], "adv")
        XCTAssertEqual(newReleases.parameters["t"], "ns")
        XCTAssertEqual(newReleases.parameters["p"], "1")
        XCTAssertEqual(newReleases.parameters["q"], "get:new7:US")
    }
    
    func test_initNewReleases_setHeaders() throws {
        let urlRequest = try newReleases.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, newReleases.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
    
    func test_initImages_setHttpMethod() {
        XCTAssertEqual(images.method, .get)
    }
    
    func test_initImages_setPath() {
        XCTAssertEqual(images.path, "")
    }
    
    func test_initImages_setParameters() {
        XCTAssertEqual(images.parameters["t"], "images")
        XCTAssertEqual(images.parameters["q"], "1234")
    }
    
    func test_initImages_setHeaders() throws {
        let urlRequest = try images.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, images.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
    
    func test_initImdbDetail_setHttpMethod() {
        XCTAssertEqual(imdbDetail.method, .get)
    }
    
    func test_initImdbDetail_setPath() {
        XCTAssertEqual(imdbDetail.path, "")
    }
    
    func test_initImdbDetail_setParameters() {
        XCTAssertEqual(imdbDetail.parameters["t"], "getimdb")
        XCTAssertEqual(imdbDetail.parameters["q"], "12345")
    }
    
    func test_initImdbDetail_setHeaders() throws {
        let urlRequest = try imdbDetail.asURLRequest()
        XCTAssertEqual(urlRequest.httpMethod, imdbDetail.method.rawValue)
        XCTAssertNotNil(urlRequest.allHTTPHeaderFields, "http headers nil")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-host"], NetworkConstants.apiHost)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields!["x-rapidapi-key"], NetworkConstants.apiKey)
    }
}
