//
//  URLs.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class URLs: Mappable{
    public var raw: String?
    public var full: String?
    public var regular: String?
    public var small: String?
    public var thumb: String?
    
    init() {
        
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.raw        <- map["raw"]
        self.full       <- map["full"]
        self.regular    <- map["regular"]
        self.small      <- map["small"]
        self.thumb      <- map["thumb"]
    }
}
