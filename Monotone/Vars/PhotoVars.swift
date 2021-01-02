//
//  PhotoVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

class PhotoVars{
    public static let topics: [(key: String, description: String)] =
        [
            (key: "nature" ,
             description : NSLocalizedString("unsplash_home_segment_nature", comment: "Nature")),
            
            (key: "people" ,
             description : NSLocalizedString("unsplash_home_segment_people", comment: "People")),
            
            (key: "street-photography",
             description: NSLocalizedString("unsplash_home_segment_street_photography", comment: "Street Photography")),
            
            (key: "arts-culture" ,
             description: NSLocalizedString("unsplash_home_segment_arts_culture", comment: "Arts & Culture")),
            
            (key: "architecture" ,
             description: NSLocalizedString("unsplash_home_segment_architecture", comment: "Architecture")),
            
            (key: "travel" ,
             description: NSLocalizedString("unsplash_home_segment_travel", comment: "Travel")),
            
            (key: "technology" ,
             description: NSLocalizedString("unsplash_home_segment_technology", comment: "Technology")),
            
            (key: "animals" ,
             description: NSLocalizedString("unsplash_home_segment_animals", comment: "Animals")),
            
            (key: "food-drink" ,
             description: NSLocalizedString("unsplash_home_segment_food_drink", comment: "Food & Drink")),
            
            (key: "sustainability" ,
             description: NSLocalizedString("unsplash_home_segment_sustainability", comment: "Sustainability"))
        ]

    public static let listOrderBys: [(key: String, description: String)] =
        [
            (key: "popular" ,
             description : NSLocalizedString("unsplash_home_segment_popular", comment: "Popular")),
            
            (key: "latest" ,
             description : NSLocalizedString("unsplash_home_segment_latest", comment: "latest"))
        ]
}
