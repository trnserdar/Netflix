//
//  SpyNavigationController.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 6.01.2021.
//

import UIKit
@testable import Netflix

class SpyNavigationController: MainNavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
}
