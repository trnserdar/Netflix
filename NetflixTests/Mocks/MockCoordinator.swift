//
//  MockCoordinator.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class MockCoordinator: SearchResulting, ResultDetailing, CastDetailing {
   
    var showResultCount = 0
    var showResultDetailCount = 0
    var showCastDetailingCount = 0
    
    func showResult(navigationTitle: String?, results: [SearchResult]) {
        showResultCount += 1
    }
    
    func showResultDetail(result: SearchResult) {
        showResultDetailCount += 1
    }
    
    func showCastDetail(person: Person) {
        showCastDetailingCount += 1
    }

}
