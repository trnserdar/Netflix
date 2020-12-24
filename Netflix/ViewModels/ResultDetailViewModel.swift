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
}
