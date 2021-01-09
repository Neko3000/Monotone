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
    init?(rawValue: (key:String, title:String)) {
        switch rawValue.key {
        
        case "nature":
            self = .nature
            
        case "people":
            self = .people

        case "street-photography":
            self = .streetPhotography

        case "arts-culture":
            self = .artsCulture

        case "architecture":
            self = .architecture
        
        case "travel":
            self = .travel

        case "technology":
            self = .technology

        case "animals":
            self = .animals

        case "food-drink":
            self = .foodDrink

        case "sustainability":
            self = .sustainability
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title:String) {
        switch self {
        
        case .nature:
            return (key: "nature" ,
                    title : NSLocalizedString("uns_home_segment_nature", comment: "Nature"))
            
        case .people:
            return (key: "people" ,
                    title : NSLocalizedString("uns_home_segment_people", comment: "People"))

        case .streetPhotography:
            return (key: "street-photography",
                    title: NSLocalizedString("uns_home_segment_street_photography", comment: "Street Photography"))

        case .artsCulture:
            return (key: "arts-culture" ,
                    title: NSLocalizedString("uns_home_segment_arts_culture", comment: "Arts & Culture"))

        case .architecture:
            return (key: "architecture" ,
                    title: NSLocalizedString("uns_home_segment_architecture", comment: "Architecture"))

        case .travel:
            return (key: "travel" ,
                    title: NSLocalizedString("uns_home_segment_travel", comment: "Travel"))

        case .technology:
            return (key: "technology" ,
                    title: NSLocalizedString("uns_home_segment_technology", comment: "Technology"))

        case .animals:
            return (key: "animals" ,
                    title: NSLocalizedString("uns_home_segment_animals", comment: "Animals"))

        case .foodDrink:
            return (key: "food-drink" ,
                    title: NSLocalizedString("uns_home_segment_food_drink", comment: "Food & Drink"))

        case .sustainability:
            return (key: "sustainability" ,
                    title: NSLocalizedString("uns_home_segment_sustainability", comment: "Sustainability"))

        }
    }
}
