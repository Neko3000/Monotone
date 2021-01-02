//
//  SideMenuPageVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

enum SideMenuPage{
    case myPhotos
    case hiring
    case licenses
    case help
    case madeWithUnsplash
}

extension SideMenuPage: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, description:String)) {
        switch rawValue {
        
        case (key:"myPhotos",
              description:NSLocalizedString("unsplash_side_menu_option_my_photos", comment: "My Photos")):
            self = .myPhotos
            
        case (key:"hiring",
              description:NSLocalizedString("unsplash_side_menu_option_hiring", comment: "Hiring")):
            self = .hiring
            
        case (key:"licenses",
              description:NSLocalizedString("unsplash_side_menu_option_licenses", comment: "Licenses")):
            self = .licenses
            
        case (key:"help",
              description:NSLocalizedString("unsplash_side_menu_option_help", comment: "Help")):
            self = .help
            
        case (key:"madeWithUnsplash",
              description:NSLocalizedString("unsplash_side_menu_option_made_with_unsplash", comment: "Made with Unsplash")):
            self = .madeWithUnsplash
            
        default: return nil
        }
    }
    
    var rawValue: (key:String, description:String) {
        switch self {
        
        case .myPhotos:
            return (key:"myPhotos",
                    description:NSLocalizedString("unsplash_side_menu_option_my_photos", comment: "My Photos"))
            
        case .hiring:
            return (key:"hiring",
                    description:NSLocalizedString("unsplash_side_menu_option_hiring", comment: "Hiring"))
            
        case .licenses:
            return (key:"licenses",
                    description:NSLocalizedString("unsplash_side_menu_option_licenses", comment: "Licenses"))
            
        case .help:
            return (key:"help",
                    description:NSLocalizedString("unsplash_side_menu_option_help", comment: "Help"))
            
        case .madeWithUnsplash:
            return (key:"madeWithUnsplash",
                    description:NSLocalizedString("unsplash_side_menu_option_made_with_unsplash", comment: "Made with Unsplash"))

        }
    }
}
