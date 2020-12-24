//
//  CoverPhoto.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/18.
//

import Foundation
import ObjectMapper

class PreviewPhoto: Mappable{
    var updatedAt: String?
    var createdAt: String?
    var urls: URLs?
    var id: String?
    
    init() {
        
    }

    required init?(map: Map) {
        self.mapping(map: map)
    }

    func mapping(map: Map) {
        updatedAt   <- map["updated_at"]
        createdAt   <- map["created_at"]
        urls        <- map["urls"]
        id          <- map["id"]
    }
}
