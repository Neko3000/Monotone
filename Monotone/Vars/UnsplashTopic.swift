//
//  PhotoVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

enum UnsplashTopic{
    case nature
    case people
    case streetPhotography
    case artsCulture
    case architecture
    case travel
    case technology
    case animals
    case foodDrink
    case sustainability
}

extension UnsplashTopic: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, description:String)) {
        switch rawValue {
        
        case (key: "nature",
              description: NSLocalizedString("unsplash_home_segment_nature", comment: "Nature")):
            self = .nature
            
        case (key: "people",
              description: NSLocalizedString("unsplash_home_segment_people", comment: "People")):
            self = .people

        case (key: "street-photography",
              description: NSLocalizedString("unsplash_home_segment_street_photography", comment: "Street Photography")):
            self = .streetPhotography

        case (key: "arts-culture",
              description: NSLocalizedString("unsplash_home_segment_arts_culture", comment: "Arts & Culture")):
            self = .artsCulture

        case (key: "architecture",
              description: NSLocalizedString("unsplash_home_segment_architecture", comment: "Architecture")):
            self = .architecture
        
        case (key: "travel",
              description: NSLocalizedString("unsplash_home_segment_travel", comment: "Travel")):
            self = .travel

        case (key: "technology",
              description: NSLocalizedString("unsplash_home_segment_technology", comment: "Technology")):
            self = .technology

        case (key: "animals",
              description: NSLocalizedString("unsplash_home_segment_animals", comment: "Animals")):
            self = .animals

        case (key: "food-drink",
              description: NSLocalizedString("unsplash_home_segment_food_drink", comment: "Food & Drink")):
            self = .foodDrink

        case (key: "sustainability",
              description: NSLocalizedString("unsplash_home_segment_sustainability", comment: "Sustainability")):
            self = .sustainability
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, description:String) {
        switch self {
        
        case .nature:
            return (key: "nature" ,
                    description : NSLocalizedString("unsplash_home_segment_nature", comment: "Nature"))
            
        case .people:
            return (key: "people" ,
                    description : NSLocalizedString("unsplash_home_segment_people", comment: "People"))

        case .streetPhotography:
            return (key: "street-photography",
                    description: NSLocalizedString("unsplash_home_segment_street_photography", comment: "Street Photography"))

        case .artsCulture:
            return (key: "arts-culture" ,
                    description: NSLocalizedString("unsplash_home_segment_arts_culture", comment: "Arts & Culture"))

        case .architecture:
            return (key: "architecture" ,
                    description: NSLocalizedString("unsplash_home_segment_architecture", comment: "Architecture"))

        case .travel:
            return (key: "travel" ,
                    description: NSLocalizedString("unsplash_home_segment_travel", comment: "Travel"))

        case .technology:
            return (key: "technology" ,
                    description: NSLocalizedString("unsplash_home_segment_technology", comment: "Technology"))

        case .animals:
            return (key: "animals" ,
                    description: NSLocalizedString("unsplash_home_segment_animals", comment: "Animals"))

        case .foodDrink:
            return (key: "food-drink" ,
                    description: NSLocalizedString("unsplash_home_segment_food_drink", comment: "Food & Drink"))

        case .sustainability:
            return (key: "sustainability" ,
                    description: NSLocalizedString("unsplash_home_segment_sustainability", comment: "Sustainability"))

        }
    }
}
