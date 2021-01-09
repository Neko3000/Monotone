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

struct MadeItem{
    public var coverImage: UIImage?
    public var title: String?
    public var description: String?
    public var username: String?
}

extension MadeCategory: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, items:[MadeItem])) {
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
    
    var rawValue: (key:String, title:String, items:[MadeItem]) {
        switch self {
        
        case .all:
            return (key:"all",
                    title:NSLocalizedString("unsplash_made_category_all_title", comment: "All"),
                    items:MadeCategory.allCases.filter({ $0 != .all }).flatMap({ category in category.rawValue.items }))
            
        case .articles:
            return (key:"articles",
                    title:NSLocalizedString("unsplash_made_category_articles_title", comment: "All"),
                    items:[
                        MadeItem(coverImage: UIImage(named: "help-articles-made-item-a"), title: "", username: "Tommy D"),
                        MadeItem(coverImage: UIImage(named: "help-articles-made-item-b"), title: "", username: "Dan Christe")
                    ])
            
        case .remixes:
            return (key:"remixes",
                    title:NSLocalizedString("unsplash_made_category_remixes_title", comment: "Remixes"),
                    items:[])
            
        case .apps:
            return (key:"apps",
                    title:NSLocalizedString("unsplash_made_category_apps_title", comment: "Apps"),
                    items:[])
            
        case .products:
            return (key:"products",
                    title:NSLocalizedString("unsplash_made_category_products_title", comment: "Products"),
                    items:[])
            
        case .websites:
            return (key:"websites",
                    title:NSLocalizedString("unsplash_made_category_websites_title", comment: "Websites"),
                    items:[])
            
        case .videos:
            return (key:"videos",
                    title:NSLocalizedString("unsplash_made_category_videos_title", comment: "Videos"),
                    items:[])

        }
    }
}
