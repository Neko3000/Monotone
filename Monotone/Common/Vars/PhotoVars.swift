//
//  PhotoVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

class PhotoVars{
    public static let topics: [(key: String, value: String)] =
        [
            (key: "nature" , value : NSLocalizedString("unsplash_home_segment_nature", comment: "Nature")),
            (key: "people" , value : NSLocalizedString("unsplash_home_segment_people", comment: "People")),
            (key: "street-photography", value: NSLocalizedString("unsplash_home_segment_street_photography", comment: "Street Photography")),
            (key: "arts-culture" , value: NSLocalizedString("unsplash_home_segment_arts_culture", comment: "Arts & Culture")),
            (key: "architecture" , value: NSLocalizedString("unsplash_home_segment_architecture", comment: "Architecture")),
            (key: "travel" , value: NSLocalizedString("unsplash_home_segment_travel", comment: "Travel")),
            (key: "technology" , value: NSLocalizedString("unsplash_home_segment_technology", comment: "Technology")),
            (key: "animals" , value: NSLocalizedString("unsplash_home_segment_animals", comment: "Animals")),
            (key: "food-drink" , value: NSLocalizedString("unsplash_home_segment_food_drink", comment: "Food & Drink")),
            (key: "sustainability" , value: NSLocalizedString("unsplash_home_segment_sustainability", comment: "Sustainability"))
        ]

    public static let listOrderBys: [(key: String, value: String)] =
        [
            (key: "popular" , value : NSLocalizedString("unsplash_home_segment_popular", comment: "Popular")),
            (key: "latest" , value : NSLocalizedString("unsplash_home_segment_latest", comment: "latest"))
        ]
}
