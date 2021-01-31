//
//  ProfileContent.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/31.
//

import UIKit

enum ProfileContent{
    case photos
    case collections
    case likedPhotos
}

extension ProfileContent: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String)) {
        switch rawValue.key {
        
        case "photos":
            self = .photos
            
        case "collections":
            self = .collections
            
        case "likedPhotos":
            self = .likedPhotos
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String) {
        switch self {
        
        case .photos:
            return (key:"photos",
                    title:"photos")
            
        case .collections:
            return (key:"collections",
                    title:"collections")
            
        case .likedPhotos:
            return (key:"likedPhotos",
                    title:"likePhotos")

        }
    }
}
