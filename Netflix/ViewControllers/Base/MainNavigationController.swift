//
//  MainNavigationController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        configureNavigationBar()
        
    }
    
    func configureNavigationBar() {
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: StyleConstants.Color.darkGray!, NSAttributedString.Key.font: StyleConstants.Font.title2!]
        
    }

}

extension MainNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
