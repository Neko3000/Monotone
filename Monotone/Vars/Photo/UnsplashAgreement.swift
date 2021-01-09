//
//  SideMenuPageVars.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/15.
//

import UIKit

// TODO: Integrate agreements as HTML files displayed by WebView.
enum UnsplashAgreement{
    case license
    // TODO: There is no Manifesto currently.
    case manifesto
    case privacyPolicy
    case termsAndConditions
    case apiTerms
}

extension UnsplashAgreement: RawRepresentable, CaseIterable{
    init?(rawValue: (key:String, title: String, content: URL?)) {
        switch rawValue.key {
        
        case "license":
            self = .license
        
        case "manifesto":
            self = .manifesto
            
        case "privacyPolicy":
            self = .privacyPolicy
            
        case "termsAndConditions":
            self = .termsAndConditions
            
        case "apiTerms":
            self = .apiTerms
            
        default:
            return nil
        }
    }
    
    var rawValue: (key:String, title: String, content: URL?) {
        switch self {
        
        case .license:
            return (key:"license",
                    title:NSLocalizedString("uns_agreement_license_title", comment: "License"),
                    content: Bundle.main.url(forResource: "license_" + (Locale.current.languageCode == "zh" ? "cn" : "en"),
                                             withExtension: "html"))
            
        case .manifesto:
            return (key:"manifesto",
                    title:NSLocalizedString("uns_agreement_manifesto_title", comment: "Manifesto"),
                    content: Bundle.main.url(forResource: "manifesto_" + (Locale.current.languageCode == "zh" ? "cn" : "en"),
                                             withExtension: "html"))

        case .privacyPolicy:
            return (key:"privacyPolicy",
                    title:NSLocalizedString("uns_agreement_privacy_policy_title", comment: "Privacy Policy"),
                    content: Bundle.main.url(forResource: "privacy_policy_" + (Locale.current.languageCode == "zh" ? "cn" : "en"),
                                             withExtension: "html"))

        case .termsAndConditions:
            return (key:"termsAndConditions",
                    title:NSLocalizedString("uns_agreement_terms_and_conditions_title", comment: "T&C"),
                    content: Bundle.main.url(forResource: "terms_and_conditions_" + (Locale.current.languageCode == "zh" ? "cn" : "en"),
                                             withExtension: "html"))

        case .apiTerms:
            return (key:"apiTerms",
                    title:NSLocalizedString("uns_agreement_api_terms_title", comment: "API Terms"),
                    content: Bundle.main.url(forResource: "api_terms_" + (Locale.current.languageCode == "zh" ? "cn" : "en"),
                                             withExtension: "html"))

        }
    }

}
