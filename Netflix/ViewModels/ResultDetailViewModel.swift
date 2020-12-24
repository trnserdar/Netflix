//
//  ResultDetailViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import Foundation

struct ResultDetailViewModel {
    
    var titleDetail: TitleDetail
    
    var titleText: String {
        return titleDetail.nfinfo?.title ?? ""
    }
    
    var releaseDateIsEnabled: Bool {
        return titleDetail.nfinfo?.released != nil ? true : false
    }
    
    var releaseDateText: String {
        return titleDetail.nfinfo?.released ?? ""
    }
    
    var countryIsEnabled: Bool {
        return titleDetail.imdbinfo?.country != nil ? true : false
    }
    
    var countryText: String {
        return titleDetail.imdbinfo?.country ?? ""
    }
    
    var runtimeIsEnabled: Bool {
        return titleDetail.imdbinfo?.runtime != nil ? true : false
    }
    
    var runtimeText: String {
        return titleDetail.imdbinfo?.runtime ?? ""
    }
    
    var imageURL: URL? {
        
        guard let urlString = titleDetail.nfinfo?.image1 else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    var ratingIsEnabled: Bool {
        return titleDetail.imdbinfo?.rating != nil || titleDetail.imdbinfo?.rating != "0" ? true : false
    }
    
    var ratingText: String {
        return titleDetail.imdbinfo?.rating ?? ""
    }
    
    var summaryText: String {
        return titleDetail.nfinfo?.synopsis ?? ""
    }
    
}
