//
//  FakeUserDefaults.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import XCTest
@testable import Netflix

class FakeUserDefaults: UserDefaultsProtocol {
    
    var dataDict: [String: Any] = [:]
    func data(forKey defaultName: String) -> Data? {
        return dataDict[defaultName] as? Data
    }
    
    func setValue(_ value: Any?, forKey defaultName: String) {
        dataDict[defaultName] = value
    }
    
}
