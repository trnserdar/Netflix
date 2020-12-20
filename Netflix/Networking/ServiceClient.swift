//
//  ServiceClient.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import Foundation
import Alamofire

protocol ServiceClientProtocol {
    func makeRequest<T: Codable>(route: URLRequestConvertible, decodingType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void)
    func makeRequest(route: URLRequestConvertible, completion: @escaping (_ response: Any?, _ error: Error?) -> Void)
}

class ServiceClient: ServiceClientProtocol {
        
    func makeRequest<T: Codable>(route: URLRequestConvertible, decodingType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void) {
        AF.request(route).validate().responseDecodable(of: T.self) { (response) in
            completion(response.value, response.error)
        }
        
    }
    
    func makeRequest(route: URLRequestConvertible, completion: @escaping (_ response: Any?, _ error: Error?) -> Void) {
        AF.request(route).validate().responseJSON { (response) in
            completion(response.value, response.error)
        }
        
    }
}
