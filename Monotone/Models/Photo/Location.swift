//
//  Location.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class Location: Mappable {

    var city: String?
    var country: String?
    var position: Position?
    var title: String?

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        city        <- map["city"]
        country     <- map["country"]
        position    <- map["position"]
        title       <- map["title"]
    }
}
