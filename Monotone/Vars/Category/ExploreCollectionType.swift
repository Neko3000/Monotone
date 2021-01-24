//
//  ExploreCollectionType.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/7.
//

import UIKit

enum ExploreCollectionType{
    case celebration
    case colors
}

extension ExploreCollectionType: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, description:String, collections:[Collection]?)) {
        switch rawValue.key {
        
        case "celebration":
            self = .celebration
            
        case "colors":
            self = .colors
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String, description:String, collections:[Collection]?) {
        switch self {
        
        case .celebration:
            return (key:"celebration",
                    title:"celebration",
                    description:"download the most popular ",
                    collections:[])
            
        case .colors:
            return (key:"colors",
                    title:"colors",
                    description:"download the most popular ",
                    collections:[])

        }
    }
}
