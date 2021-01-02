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
    init?(rawValue: (key:String, title: String, content:String)) {
        switch rawValue {
        
        case (key:"license",
              title:NSLocalizedString("unsplash_agreement_license_title", comment: "License"),
              content:NSLocalizedString("unsplash_agreement_license_content", comment: "")):
            self = .license
        
        case (key:"manifesto",
              title:NSLocalizedString("unsplash_agreement_manifesto_title", comment: "Manifesto"),
              content:NSLocalizedString("unsplash_agreement_manifesto_content", comment: "")):
            self = .manifesto
            
        case (key:"privacyPolicy",
              title:NSLocalizedString("unsplash_agreement_privacy_policy_title", comment: "Privacy Policy"),
              content:NSLocalizedString("unsplash_agreement_privacy_policy_content", comment: "")):
            self = .privacyPolicy
            
        case (key:"termsAndConditions",
              title:NSLocalizedString("unsplash_agreement_terms_and_conditions_title", comment: "T&C"),
              content:NSLocalizedString("unsplash_agreement_terms_and_conditions_content", comment: "")):
            self = .termsAndConditions
            
        case (key:"apiTerms",
              title:NSLocalizedString("unsplash_agreement_api_terms_title", comment: "API Terms"),
              content:NSLocalizedString("unsplash_agreement_api_terms_content", comment: "")):
            self = .apiTerms
            
        default: return nil
        }
    }
    
    var rawValue: (key:String, title: String, content:String) {
        switch self {
        
        case .license:
            return (key:"license",
                    title:NSLocalizedString("unsplash_agreement_license_title", comment: "License"),
                    content:NSLocalizedString("unsplash_agreement_license_content", comment: ""))
            
        case .manifesto:
            return (key:"manifesto",
                    title:NSLocalizedString("unsplash_agreement_manifesto_title", comment: "Manifesto"),
                    content:NSLocalizedString("unsplash_agreement_manifesto_content", comment: ""))
            
        case .privacyPolicy:
            return (key:"privacyPolicy",
                    title:NSLocalizedString("unsplash_agreement_privacy_policy_title", comment: "Privacy Policy"),
                    content:NSLocalizedString("unsplash_agreement_privacy_policy_content", comment: ""))
            
        case .termsAndConditions:
            return (key:"termsAndConditions",
                    title:NSLocalizedString("unsplash_agreement_terms_and_conditions_title", comment: "T&C"),
                    content:NSLocalizedString("unsplash_agreement_terms_and_conditions_content", comment: ""))
            
        case .apiTerms:
            return (key:"apiTerms",
                    title:NSLocalizedString("unsplash_agreement_api_terms_title", comment: "API Terms"),
                    content:NSLocalizedString("unsplash_agreement_api_terms_content", comment: ""))

        }
    }
}
