//
//  SideMenuPage.swift
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
        switch rawValue.key {
        
        case "myPhotos":
            self = .myPhotos
            
        case "hiring":
            self = .hiring
            
        case "licenses":
            self = .licenses
            
        case "help":
            self = .help
            
        case "madeWithUnsplash":
            self = .madeWithUnsplash
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, description:String) {
        switch self {
        
        case .myPhotos:
            return (key:"myPhotos",
                    description:NSLocalizedString("uns_side_menu_option_my_photos", comment: "My Photos"))
            
        case .hiring:
            return (key:"hiring",
                    description:NSLocalizedString("uns_side_menu_option_hiring", comment: "Hiring"))
            
        case .licenses:
            return (key:"licenses",
                    description:NSLocalizedString("uns_side_menu_option_licenses", comment: "Licenses"))
            
        case .help:
            return (key:"help",
                    description:NSLocalizedString("uns_side_menu_option_help", comment: "Help"))
            
        case .madeWithUnsplash:
            return (key:"madeWithUnsplash",
                    description:NSLocalizedString("uns_side_menu_option_made_with_unsplash", comment: "Made with Unsplash"))

        }
    }
}
