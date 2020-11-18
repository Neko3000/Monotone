//
//  Position.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class Position: Mappable {

    var latitude: String?
    var longitude: String?

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }
}
