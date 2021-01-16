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
    public var name: String?
    public var state: String?
    public var sizes: [String]?
    public var price: Decimal?
    
    public var detailImages: [UIImage?]?
    public var username: String?
}

extension StoreCategory: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title:String, bannerItems:[StoreItem], items:[StoreItem])) {
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
    
    var rawValue: (key:String, title:String, bannerItems:[StoreItem], items:[StoreItem]) {
        switch self {
        
        case .home:
            
            let allItems = StoreCategory.allCases
                .filter({ $0 != .home && $0 != .allProducts })
                .flatMap({ category in category.rawValue.items })
            
            let bannerItems = allItems.choose(1)
            
            return (key:"home",
                    title:NSLocalizedString("uns_store_category_home", comment: "Home"),
                    bannerItems:bannerItems,
                    items:allItems)
        
        case .allProducts:
            
            let allItems = StoreCategory.allCases
                .filter({ $0 != .home && $0 != .allProducts })
                .flatMap({ category in category.rawValue.items })
            
            let bannerItems = allItems.choose(1)

            return (key:"allProducts",
                    title:NSLocalizedString("uns_store_category_all", comment: "All Products"),
                    bannerItems:bannerItems,
                    items:allItems)
            
        case .madeByUnsplash:
            return (key:"madeByUnsplash",
                    title:NSLocalizedString("uns_store_category_made_by_unsplash", comment: "Made by Unsplash"),
                    bannerItems: [],
                    items:[
                        StoreItem(coverImage: UIImage(named: "store-home-list-item-a"),
                                  title: "Unsplash Sweatshirt",
                                  description: "Designed in NYC & Montreal. Handmade in Canada.The Urban Explorer Sweatshirt is made of high-quality 400gsm 100% French terry cotton. French terry is incredibly light and durable without sacrificing that snuggly warm blanket feeling. A tonal black-on-black foil script makes this a subtle piece you can wear for any occasion.Ships in one-of-a-kind packaging designed by us and sealed with a custom sticker, courtesy of our friends at Stickermule.",
                                  name: "The Urban Explorer Sweatshirt",
                                  state: "For Sale",
                                  sizes: ["XS","S","M","L","XL"],
                                  price: 95.00,
                                  detailImages: [UIImage(named: "store-details-item-a-image-1"),
                                                 UIImage(named: "store-details-item-a-image-2"),
                                                 UIImage(named: "store-details-item-a-image-3"),
                                                 UIImage(named: "store-details-item-a-image-4")],
                                  username: "Unsplash"),
                        
                        StoreItem(coverImage: UIImage(named: "store-home-list-item-b"),
                                  title: "Unsplash Inspish",
                                  description: "Designed in NYC & Montreal. Handmade in Canada.The Urban Explorer Sweatshirt is made of high-quality 400gsm 100% French terry cotton. French terry is incredibly light and durable without sacrificing that snuggly warm blanket feeling. A tonal black-on-black foil script makes this a subtle piece you can wear for any occasion.Ships in one-of-a-kind packaging designed by us and sealed with a custom sticker, courtesy of our friends at Stickermule.",
                                  name: "The Urban Explorer Sweatshirt",
                                  state: "For Sale",
                                  sizes: ["XS","S","M","L","XL"],
                                  price: 45.00,
                                  detailImages: [UIImage(named: "store-details-item-a-image-1"),
                                                 UIImage(named: "store-details-item-a-image-2"),
                                                 UIImage(named: "store-details-item-a-image-3"),
                                                 UIImage(named: "store-details-item-a-image-4")],
                                  username: "Unsplash")
                    ])
            
        case .madeWithFriends:
            return (key:"madeWithFriends",
                    title:NSLocalizedString("uns_store_category_made_with_friends", comment: "Made with Friends"),
                    bannerItems: [],
                    items:[
                        StoreItem(coverImage: UIImage(named: "store-home-banner-item"),
                                  title: "Limited Edition: The Urban Explorer Sweatshirt",
                                  description: "Designed in NYC & Montreal. Handmade in Canada.The Urban Explorer Sweatshirt is made of high-quality 400gsm 100% French terry cotton. French terry is incredibly light and durable without sacrificing that snuggly warm blanket feeling. A tonal black-on-black foil script makes this a subtle piece you can wear for any occasion.Ships in one-of-a-kind packaging designed by us and sealed with a custom sticker, courtesy of our friends at Stickermule.",
                                  state: "Sold Out",
                                  sizes: ["XS","S","M","L","XL"],
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
