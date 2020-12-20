//
//  StyleConstants.swift
//  Netflix
//
//  Created by SERDAR TURAN on 20.12.2020.
//

import Foundation
import UIKit

struct StyleConstants {
    
    struct TabBar {
        
        static let barTintColor = UIColor.white
        static let tintColor = StyleConstants.Color.turquoise
        static let unselectedItemTintColor = StyleConstants.Color.gray
                
        enum TabBarTitle: String {
            case home = "Home"
            case genres = "Genres"
            case search = "Search"
            case profile = "Profile"
        }
        
        enum TabBarImage: String {
            case home = "house"
            case genres = "tray.full"
            case search = "magnifyingglass"
            case profile = "person.crop.circle"
        }
        
    }
    
    struct Color {
        static let turquoise = UIColor(hex: "#19d3da")
        static let darkGray = UIColor(hex: "#373a40")
        static let gray = UIColor(hex: "#686d76")
        static let lightGray = UIColor(hex: "#eeeeee")
        
    }
    
    
}
