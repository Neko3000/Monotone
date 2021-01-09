//
//  FAQCategoryVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2021/1/7.
//

import UIKit

enum FAQCategory{
    case account
    case licenses
}

extension FAQCategory: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, icon:UIImage, title:String, description:String, count:Int)) {
        switch rawValue.key {
        
        case "account":
            self = .account
            
        case "licenses":
            self = .licenses
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, icon: UIImage, title:String, description:String, count:Int) {
        switch self {
        
        case .account:
            return (key:"account",
                    icon:UIImage(named: "help-category-account")!,
                    title:NSLocalizedString("uns_help_account_title", comment: "Managing your Unsplash account"),
                    description:NSLocalizedString("uns_help_account_description", comment: "Learn about your Unsplash account and how to manage your preferences"),
                    count:10)
            
        case .licenses:
            return (key:"licenses",
                    icon:UIImage(named: "help-category-licenses")!,
                    title:NSLocalizedString("uns_help_license_title", comment: "Unsplash Licens"),
                    description:NSLocalizedString("uns_help_license_description", comment: "The official Unsplash License guide and FAQ"),
                    count:10)

        }
    }
}
