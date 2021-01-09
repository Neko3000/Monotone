//
//  StoreCategory.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/10.
//

import UIKit

enum StoreCategory{
    case home
    case allProducts
    case madeByUnsplash
    case madeWithFriends
}

struct StoreItem{
    public var coverImage: UIImage?
    public var title: String?
    public var description: String?
    public var state: String?
    public var price: Decimal?
    
    public var detailImages: [UIImage]?
    public var username: String?
}


extension StoreCategory: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, items:[StoreItem])) {
        switch rawValue.key {
        
        case "home":
            self = .home
            
        case "allProducts":
            self = .allProducts
            
        case "madeBuUnsplash":
            self = .madeByUnsplash
            
        case "madeWithFriends":
            self = .madeWithFriends
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String, items:[StoreItem]) {
        switch self {
        
        case .home:
            return (key:"home",
                    title:"Home",
                    items:StoreCategory.allCases.filter({ $0 != .home && $0 != .allProducts }).flatMap({ category in category.rawValue.items }))
        
        case .allProducts:
            return (key:"allProducts",
                    title:"All Products",
                    items:StoreCategory.allCases.filter({ $0 != .home && $0 != .allProducts  }).flatMap({ category in category.rawValue.items }))
            
        case .madeByUnsplash:
            return (key:"madeByUnsplash",
                    title:"Made by Unsplash",
                    items:[])
            
        case .madeWithFriends:
            return (key:"madeWithFriends",
                    title:"Made with Friends",
                    items:[])

        }
    }
}
