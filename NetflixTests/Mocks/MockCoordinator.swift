//
//  MockCoordinator.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 13.01.2021.
//

import XCTest
@testable import Netflix

class MockCoordinator: Coordinator, SearchResulting, ResultDetailing, CastDetailing {
   
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = MainNavigationController()

    var startCount = 0
    var showResultCount = 0
    var showResultDetailCount = 0
    var showCastDetailingCount = 0
    
    func start() {
        startCount += 1
    }
    
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
