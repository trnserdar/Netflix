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
        
    struct Font {
        static let largeTitle = UIFont(name: "HelveticaNeue-Medium", size: 22.0)
        static let title1 = UIFont(name: "HelveticaNeue-Medium", size: 19.0)
        static let title2 = UIFont(name: "HelveticaNeue-Medium", size: 17.0)
        static let title3 = UIFont(name: "HelveticaNeue-Medium", size: 15.5)
        static let headline = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
        static let body = UIFont(name: "HelveticaNeue", size: 14.0)
        static let callout = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        static let subhead = UIFont(name: "HelveticaNeue-Medium", size: 12.5)
        static let footnote = UIFont(name: "HelveticaNeue-Medium", size: 11.5)
        static let caption1 = UIFont(name: "HelveticaNeue-Medium", size: 11.0)
        static let caption2 = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        
    }
    
    
}
