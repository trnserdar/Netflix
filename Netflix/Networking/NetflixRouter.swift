//
//  NetflixRouter.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import Foundation
import Alamofire

enum NetflixRouter: URLRequestConvertible {
    
    static let baseURLPath = NetworkConstants.baseURL
    
    case genres
    case search(query: String, genreId: String = "0") // get:new100
    case titleDetail(id: String)
    case episodeDetail(id: String)
    case newReleases(days: String, country: String = "US")
    case images(id: String)
    case imdbDetail(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .genres, .search, .titleDetail, .episodeDetail, .newReleases, .images, .imdbDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    var parameters: [String: String] {
        
        switch self {
        case .genres:
            return ["t": "genres"]
        case .search(query: let query, genreId: let genreId):
            return ["t": "ns", "cl": "all", "st": "adv", "ob": "Relevance", "p": "1", "sa": "and", "q": "\(query)-!1900,2020-!0,5-!0,10-!\(genreId)-!Any-!Any-!Any-!gt100-!%7Bdownloadable%7D"]
        case .titleDetail(id: let id):
            return ["t": "loadvideo", "q": id]
        case .episodeDetail(id: let id):
            return ["t": "episodes", "q": id]
        case .newReleases(days: let days, country: let country):
            return ["st": "adv", "t": "ns", "p": "1", "q": "get:new\(days):\(country)"]
        case .images(id: let id):
            return ["t": "images", "q": id]
        case .imdbDetail(id: let id):
            return ["t": "getimdb", "q": id]
        }
    }
    
    // MARK: - URLRequest
    public func asURLRequest() throws -> URLRequest {
        
        let url = try NetflixRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 20
        
        request.addValue(NetworkConstants.apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(NetworkConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}

