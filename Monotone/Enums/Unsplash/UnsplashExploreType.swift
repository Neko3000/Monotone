//
//  UnsplashExploreType.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/24.
//

import UIKit

enum UnsplashExploreType{
    case explore
    case popular
}

extension UnsplashExploreType: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String)) {
        switch rawValue.key {
        
        case "explore":
            self = .explore
            
        case "popular":
            self = .popular
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String) {
        switch self {
            
        case .explore:
            return (key: "explore",
                    title : "explore")
            
        case .popular:
            return (key: "popular",
                    title : "popular")
        }
    }
}
