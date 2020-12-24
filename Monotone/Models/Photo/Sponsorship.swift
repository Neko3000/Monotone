//
//  Photo.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class Sponsorship: Mappable{
    
    // var impressionURLs: []?
    var tagline: String?
    var taglineURL: String?
    var sponsor: User?

    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        // impressionURLs <- map["impression_urls"]
        tagline     <- map["tagline"]
        taglineURL  <- map["tagline_url"]
        sponsor     <- map["sponsor"]
    }
}








