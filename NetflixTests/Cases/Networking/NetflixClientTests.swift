//
//  NetflixClientTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 7.01.2021.
//

import XCTest
@testable import Netflix

class NetflixClientTests: XCTestCase {

    var sut: NetflixClient!
    var mockServiceClient: MockServiceClient!
    
    override func setUp() {
        super.setUp()
        mockServiceClient = MockServiceClient()
        sut = NetflixClient(serviceClient: mockServiceClient)
    }
    
    override func tearDown() {
        sut = nil
        mockServiceClient = nil
        super.tearDown()
    }
    
    func givenData(sourceName: String) -> Data? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: sourceName, ofType: "json") else {
            fatalError("\(sourceName).json not found")
        }
        
        do {
            return try Data(contentsOf: URL(fileURLWithPath: pathString), options: .mappedIfSafe)
        } catch {
            return nil
        }
    }
    
    func test_netflixClient_getGenres_setRequestCount() {
        sut.getGenres { (genre, error) in
            XCTAssertEqual(self.mockServiceClient.makeRequestJSONCount, 1)
        }
    }
    
    func test_netflixClient_getGenres_whenResponseEmpty_setGenres() {
        sut.getGenres { (genres, error) in
            XCTAssertNil(genres)
        }
        mockServiceClient.responseJSONCompletion?([:], nil)
    }
    
    func test_netflixClient_getGenres_whenGivenResponse_setGenres() {
        sut.getGenres { (genres, error) in
            XCTAssertEqual(genres?.first?.name ?? "", "Test Genre")
        }
        mockServiceClient.responseJSONCompletion?(["ITEMS": [["Test Genre": [1]]]], nil)
    }
    
    func test_netflixClient_search_setRequestCount() {
        sut.search(query: "") { (_, _) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
    }
    
    func test_netflixClient_search_whenResponseEmpty_setSearchResults() {
        sut.search(query: "") { (results, _) in
            XCTAssertNil(results)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_search_whenGivenResponse_setSearchResults() {
        sut.search(query: "") { (results, _) in
            XCTAssertEqual(results?.count, 39)
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "search"), nil)
    }
    
    func test_netflixClient_titleDetail_setRequestCount() {
        sut.titleDetail(netflixId: "") { (_, _) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
    }
    
    func test_netflixClient_titleDetail_whenResponseEmpty_setTitleDetail() {
        sut.titleDetail(netflixId: "") { (titleDetail, _) in
            XCTAssertNil(titleDetail)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_titleDetail_whenGivenResponse_setTitleDetail() {
        sut.titleDetail(netflixId: "") { (titleDetail, _) in
            XCTAssertEqual(titleDetail?.nfinfo?.title, "Brooklyn Nine-Nine")
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "titleDetail"), nil)
    }
        
    func test_netflixClient_episodeDetail_setRequestCount() {
        sut.episodeDetail(netflixId: "1") { (results, error) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "episodes")!, nil)
    }
    
    func test_netflixClient_episodeDetail_whenResponseEmpty_setResults() {
        sut.episodeDetail(netflixId: "1") { (results, error) in
            XCTAssertNil(results)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_episodeDetail_whenGivenResponse_setResults() {
        sut.episodeDetail(netflixId: "1") { (results, error) in
            XCTAssertEqual(results?.count, 7)
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "episodes")!, nil)
    }
    
    func test_netflixClient_newReleases_setRequestCount() {
        sut.newReleases(days: "7") { (_, _) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
    }
    
    func test_netflixClient_newReleases_whenResponseEmpty_setResults() {
        sut.newReleases(days: "7") { (results, _) in
            XCTAssertNil(results)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_newReleases_whenGivenResponse_setResults() {
        sut.newReleases(days: "7") { (results, _) in
            XCTAssertEqual(results?.count, 27)
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "newReleases"), nil)
    }
    
    func test_netflixClient_images_setRequestCount() {
        sut.images(netflixId: "") { (_, _) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
    }
    
    func test_netflixClient_images_whenResponseEmpty_setImages() {
        sut.images(netflixId: "") { (results, _) in
            XCTAssertNil(results)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_images_whenGivenResponse_setImages() {
        sut.images(netflixId: "") { (results, _) in
            XCTAssertNotNil(results)
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "images"), nil)
    }
    
    func test_netflixClient_imdbDetail_setRequestCount() {
        sut.imdbDetail(netflixId: "") { (_, _) in
            XCTAssertEqual(self.mockServiceClient.makeRequestCount, 1)
        }
    }
    
    func test_netflixClient_imdbDetail_whenResponseEmpty_setImdbInfo() {
        sut.imdbDetail(netflixId: "") { (imdbInfo, _) in
            XCTAssertNil(imdbInfo)
        }
        mockServiceClient.responseDataCompletion?(nil, nil)
    }
    
    func test_netflixClient_imdbDetail_whenGivenResponse_setImdbInfo() {
        sut.imdbDetail(netflixId: "") { (imdbInfo, _) in
            XCTAssertEqual(imdbInfo?.type, "series")
        }
        mockServiceClient.responseDataCompletion?(givenData(sourceName: "imdbInfo"), nil)
    }
    
    func test_netflixClient_convertToModel_whenGivenResponse() {
        let data = givenData(sourceName: "episodes")
        let episodeResponse = sut.convertToModel(data: data!, decodingType: EpisodeResponse.self)
        XCTAssertNotNil(episodeResponse)
    }
    
    func test_netflixClient_convertToModel_whenResponseEmpty() {
        let data = givenData(sourceName: "episodesBroken")
        let episodeResponse = sut.convertToModel(data: data!, decodingType: EpisodeResponse.self)
        XCTAssertNil(episodeResponse)
    }
}
