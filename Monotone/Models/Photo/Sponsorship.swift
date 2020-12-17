//
//  Photo.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class Sponsorship: Mappable{
    
    // var impressionUrls: []?
    var tagline: String?
    var taglineUrl: String?
    var sponsor: User?

    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        // impressionUrls <- map["impression_urls"]
        tagline     <- map["tagline"]
        taglineUrl  <- map["tagline_url"]
        sponsor     <- map["sponsor"]
    }
}








