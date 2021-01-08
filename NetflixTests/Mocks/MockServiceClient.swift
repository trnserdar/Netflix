//
//  MockServiceClient.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 7.01.2021.
//

import XCTest
@testable import Netflix
import Alamofire

class MockServiceClient: ServiceClientProtocol {
    
    var makeRequestCount = 0
    var requestDict: [String: Any] = [:]
    var responseDataCompletion: ((Data?, Error?) -> Void)!
        
    var makeRequestJSONCount = 0
    var requestJSONDict: [String: Any] = [:]
    var responseJSONCompletion: ((Any?, Error?) -> Void)!
    
    func makeRequestWithData(route: URLRequestConvertible, completion: @escaping (Data?, Error?) -> Void) {
        makeRequestCount += 1
        requestDict = ["urlString": route.urlRequest?.url?.absoluteString ?? "", "method": route.urlRequest?.method?.rawValue ?? ""]
        responseDataCompletion = completion
    }
    
    func makeRequest(route: URLRequestConvertible, completion: @escaping (Any?, Error?) -> Void) {
        makeRequestJSONCount += 1
        requestJSONDict = ["urlString": route.urlRequest?.url?.absoluteString ?? "", "method": route.urlRequest?.method?.rawValue ?? ""]
        responseJSONCompletion = completion
    }

}
