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

class SideMenuPageVars{

    public static let pages: [(key:SideMenuPage, value:String)] =
        [
            (key: .myPhotos, value: NSLocalizedString("unsplash_side_menu_option_my_photos", comment: "My Photos")),
            (key: .hiring, value: NSLocalizedString("unsplash_side_menu_option_hiring", comment: "Hiring")),
            (key: .licenses, value: NSLocalizedString("unsplash_side_menu_option_licenses", comment: "Licenses")),
            (key: .help, value: NSLocalizedString("unsplash_side_menu_option_help", comment: "Help")),
            (key: .madeWithUnsplash,  value: NSLocalizedString("unsplash_side_menu_option_made_with_unsplash", comment: "Made with Unsplash")),
        ]
}
