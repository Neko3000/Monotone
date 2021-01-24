//
//  ExplorePhotoType.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/7.
//

import UIKit

enum ExplorePhotoType{
    case business
    case technology
}

extension ExplorePhotoType: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, description:String, keywords:[String]?, previewPhotos:[Photo]?)) {
        switch rawValue.key {
        
        case "business":
            self = .business
            
        case "technology":
            self = .technology
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String, description:String, keywords:[String]?, previewPhotos:[Photo]?) {
        switch self {
        
        case .business:
            return (key:"business",
                    title:"Business images",
                    description:"Browse these images",
                    keywords:["Office","Work"],
                    previewPhotos:[])
            
        case .technology:
            return (key:"technology",
                    title:"Technology images",
                    description:"Browse these images",
                    keywords:["iPad","Phone"],
                    previewPhotos:[])

        }
    }
}
