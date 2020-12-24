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
    
    init() {
        
    }

    required init?(map: Map) {
        self.mapping(map: map)
    }

    func mapping(map: Map) {
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
    }
}
