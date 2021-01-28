//
//  ListOrderBy.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

enum ListOrderBy{
    case popular
    case latest
}

extension ListOrderBy: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String)) {
        switch rawValue.key {
        
        case "popular":
            self = .popular
            
        case "latest":
            self = .latest
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String) {
        switch self {
        
        case .popular:
            return (key: "popular",
                    title : NSLocalizedString("uns_home_segment_popular", comment: "Popular"))
            
        case .latest:
            return (key: "latest",
                    title : NSLocalizedString("uns_home_segment_latest", comment: "Latest"))
        }
    }
}
