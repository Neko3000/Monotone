//
//  MadeCategory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/7.
//

import UIKit

enum MadeCategory{
    case all
    case articles
    case remixes
    case apps
    case products
    case websites
    case videos
}

class MadeItem{
    public var coverImage: UIImage?
    public var title: String?
    public var description: String?
    public var username: String?
}

extension MadeCategory: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, description:String, items:[MadeItem])) {
        switch rawValue.key {
        
        case "all":
            self = .all
            
        case "articles":
            self = .articles
            
        case "remixes":
            self = .remixes
            
        case "apps":
            self = .apps
            
        case "products":
            self = .products
            
        case "websites":
            self = .websites
            
        case "videos":
            self = .videos
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String, description:String, items:[MadeItem]) {
        switch self {
        
        case .all:
            return (key:"all",
                    title:"All",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:MadeCategory.allCases.flatMap({ category in category.rawValue.items }))
            
        case .articles:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])
            
        case .remixes:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])
            
        case .apps:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])
            
        case .products:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])
            
        case .websites:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])
            
        case .videos:
            return (key:"articles",
                    title:"Articles",
                    description:"Learn about your Unsplash account and how to manage your preferences",
                    items:[])

        }
    }
}
