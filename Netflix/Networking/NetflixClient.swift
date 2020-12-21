//
//  NetflixClient.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import Foundation

class NetflixClient {
    
    private let serviceClient: ServiceClientProtocol
    
    init(serviceClient: ServiceClientProtocol = ServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func getGenres(completion: @escaping (_ genres: [Genre]?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.genres) { (response, error) in
            
            guard error == nil,
                  let response = response,
                  let dict = response as? [String: Any],
                  let items = dict["ITEMS"] as? [[String: [Int]]] else {
                completion(nil, error)
                return
            }
            
            var genres: [Genre] = []
            items.forEach { (item) in
                for (key, value) in item {
                    genres.append(Genre(name: key, ids: value))
                }
            }
        
            completion(genres, nil)
        }
    }
    
    func search(query: String, genreId: String = "0", completion: @escaping (_ searchResults: [SearchResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.search(query: query, genreId: genreId), decodingType: SearchResultResponse.self) { (response, error) in
            
            guard let response = response,
                  let items = response.items,
                  items.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(items, nil)
        }
    }
    
    func titleDetail(netflixId: String, completion: @escaping (_ titleDetail: TitleDetail?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.titleDetail(id: netflixId), decodingType: TitleDetailResponse.self) { (response, error) in
            
            guard let response = response,
                  let result = response.result else {
                completion(nil, error)
                return
            }
            
            completion(result, nil)
        }
    }
    
    func episodeDetail(netflixId: String, completion: @escaping (_ episodeDetail: [EpisodeResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.episodeDetail(id: netflixId), decodingType: EpisodeResponse.self) { (response, error) in
            
            guard let response = response,
                  let results = response.results else {
                completion(nil, error)
                return
            }
            
            completion(results, nil)
        }
    }
    
    func newReleases(days: String, completion: @escaping (_ newReleases: [SearchResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.newReleases(days: days), decodingType: SearchResultResponse.self) { (response, error) in
            
            guard let response = response,
                  let items = response.items,
                  items.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(items, nil)
        }
    }
    
    func images(netflixId: String, completion: @escaping (_ imageResults: [ImageResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.images(id: netflixId), decodingType: ImageResponse.self) { (response, error) in
            
            guard let response = response,
                  let results = response.results,
                  results.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(results, nil)
        }
    }
    
    func imdbDetail(netflixId: String, completion: @escaping (_ imdbDetail: Imdbinfo?, _ error: Error?) -> Void) {
        serviceClient.makeRequest(route: NetflixRouter.imdbDetail(id: netflixId), decodingType: Imdbinfo.self, completion: completion)
    }
    
}
