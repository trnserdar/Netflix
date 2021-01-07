//
//  ServiceClientTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 7.01.2021.
//

import XCTest
@testable import Netflix
import Alamofire

class ServiceClientTests: XCTestCase {

    var sut: ServiceClient!
    
    override func setUp() {
        super.setUp()
        sut = ServiceClient()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_initServiceClient_conformsToServiceClientProtocol() {
        XCTAssertTrue((sut as AnyObject) is ServiceClientProtocol)
    }
    
    func test_serviceClient_makeRequest_whenGivenId_setTitleDetail() {
        let requestExpectation = expectation(description: "Request Expectation")
        var titleDetail: TitleDetail?
        sut.makeRequest(route: NetflixRouter.titleDetail(id: "81297141"), decodingType: TitleDetailResponse.self) { (response, responseError) in
            titleDetail = response?.result
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 10.0)
        XCTAssertEqual(titleDetail?.nfinfo?.type, "movie")
    }
    
    func test_serviceClient_makeRequest_whenGivenWrongId_setTitleDetail() {
        let requestExpectation = expectation(description: "Request Expectation")
        var titleDetail: TitleDetail?
        sut.makeRequest(route: NetflixRouter.titleDetail(id: "9999999999"), decodingType: TitleDetailResponse.self) { (response, _) in
            titleDetail = response?.result
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 10.0)
        XCTAssertNil(titleDetail)
    }
    
    func test_serviceClient_makeRequest_whenResponseJSON_setGenres() {
        let requestExpectation = expectation(description: "Request Expectation")
        var genresResponse: Any?
        sut.makeRequest(route: NetflixRouter.genres) { (response, _) in
            genresResponse = response
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 10.0)
        XCTAssertNotNil(genresResponse)
    }
    
    func test_serviceClient_makeRequest_whenResponseJSON_setTitleDetail() {
        let requestExpectation = expectation(description: "Request Expectation")
        var titleDetail: Any?
        sut.makeRequest(route: NetflixRouter.titleDetail(id: "999999999")) { (response, _) in
            titleDetail = response
            requestExpectation.fulfill()
        }
        wait(for: [requestExpectation], timeout: 10.0)
        XCTAssertNil(titleDetail)
    }
}
