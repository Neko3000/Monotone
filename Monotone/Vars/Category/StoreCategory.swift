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
    
    public var detailImages: [UIImage?]?
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
                    items:[
                        StoreItem(coverImage: UIImage(named: "store-home-list-item-a"),
                                  title: "Unsplash Sweatshirt",
                                  price: 95.00,
                                  detailImages: [UIImage(named: "store-details-item-a-image-1"),
                                                 UIImage(named: "store-details-item-a-image-2"),
                                                 UIImage(named: "store-details-item-a-image-3"),
                                                 UIImage(named: "store-details-item-a-image-4")],
                                  username: "Unsplash"),
                        
                        StoreItem(coverImage: UIImage(named: "store-home-list-item-b"),
                                  title: "Unsplash Inspish",
                                  price: 45.00,
                                  detailImages: [UIImage(named: "store-details-item-a-image-1"),
                                                 UIImage(named: "store-details-item-a-image-2"),
                                                 UIImage(named: "store-details-item-a-image-3"),
                                                 UIImage(named: "store-details-item-a-image-4")],
                                  username: "Unsplash")
                    ])
            
        case .madeWithFriends:
            return (key:"madeWithFriends",
                    title:"Made with Friends",
                    items:[
                        StoreItem(coverImage: UIImage(named: "store-home-banner-item"),
                                  title: "Limited Edition: The Urban Explorer Sweatshirt",
                                  state: "Sold Out",
                                  price: 95.00,
                                  detailImages: [UIImage(named: "store-details-item-a-image-1"),
                                                 UIImage(named: "store-details-item-a-image-2"),
                                                 UIImage(named: "store-details-item-a-image-3"),
                                                 UIImage(named: "store-details-item-a-image-4")],
                                  username: "Unsplash x van Schneider"),
                    ])

        }
    }
}
