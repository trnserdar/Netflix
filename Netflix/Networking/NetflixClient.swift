//
//  NetflixClient.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import Foundation

protocol NetflixClientProtocol {
    func getGenres(completion: @escaping (_ genres: [Genre]?, _ error: Error?) -> Void)
    func search(query: String, genreId: String, completion: @escaping (_ searchResults: [SearchResult]?, _ error: Error?) -> Void)
    func titleDetail(netflixId: String, completion: @escaping (_ titleDetail: TitleDetail?, _ error: Error?) -> Void)
    func episodeDetail(netflixId: String, completion: @escaping (_ episodeDetail: [EpisodeResult]?, _ error: Error?) -> Void)
    func newReleases(days: String, completion: @escaping (_ newReleases: [SearchResult]?, _ error: Error?) -> Void)
    func images(netflixId: String, completion: @escaping (_ imageResults: [ImageResult]?, _ error: Error?) -> Void)
    func imdbDetail(netflixId: String, completion: @escaping (_ imdbDetail: Imdbinfo?, _ error: Error?) -> Void)
}

class NetflixClient: NetflixClientProtocol {
    
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
        serviceClient.makeRequestWithData(route: NetflixRouter.search(query: query, genreId: genreId)) { (responseData, error) in
    
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: SearchResultResponse.self),
                  let items = response.items,
                  items.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(items, nil)
        }
    }
    
    func titleDetail(netflixId: String, completion: @escaping (_ titleDetail: TitleDetail?, _ error: Error?) -> Void) {
        serviceClient.makeRequestWithData(route: NetflixRouter.titleDetail(id: netflixId)) { (responseData, error) in
            
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: TitleDetailResponse.self),
                  let result = response.result else {
                completion(nil, error)
                return
            }
            
            completion(result, nil)
        }
    }
    
    func episodeDetail(netflixId: String, completion: @escaping (_ episodeDetail: [EpisodeResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequestWithData(route: NetflixRouter.episodeDetail(id: netflixId)) { (responseData, error) in
            
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: EpisodeResponse.self),
                  let results = response.results else {
                completion(nil, error)
                return
            }
            
            completion(results, nil)
        }
    }
    
    func newReleases(days: String, completion: @escaping (_ newReleases: [SearchResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequestWithData(route: NetflixRouter.newReleases(days: days)) { (responseData, error) in
            
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: SearchResultResponse.self),
                  let items = response.items,
                  items.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(items, nil)
        }
    }
    
    func images(netflixId: String, completion: @escaping (_ imageResults: [ImageResult]?, _ error: Error?) -> Void) {
        serviceClient.makeRequestWithData(route: NetflixRouter.images(id: netflixId)) { (responseData, error) in
            
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: ImageResponse.self),
                  let results = response.results,
                  results.count > 0 else {
                completion(nil, error)
                return
            }
            
            completion(results, nil)
        }
    }
    
    func imdbDetail(netflixId: String, completion: @escaping (_ imdbDetail: Imdbinfo?, _ error: Error?) -> Void) {
        serviceClient.makeRequestWithData(route: NetflixRouter.imdbDetail(id: netflixId)) { (responseData, error) in
            
            guard let responseData = responseData,
                  let response = self.convertToModel(data: responseData, decodingType: Imdbinfo.self) else {
                completion(nil, error)
                return
            }
            
            completion(response, nil)
        }
    }
    
    func convertToModel<T: Codable>(data: Data, decodingType: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
