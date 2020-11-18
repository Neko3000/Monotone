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
    var urls: Urls?
    var id: String?

    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        updatedAt   <- map["updated_at"]
        createdAt   <- map["created_at"]
        urls        <- map["urls"]
        id          <- map["id"]
    }
}
