//
//  AppDelegate.swift
//  Netflix
//
//  Created by SERDAR TURAN on 19.12.2020.
//

import UIKit

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = TabBarViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

