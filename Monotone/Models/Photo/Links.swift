//
//  Links.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class Links: Mappable{
    public var selfLink: String?
    public var html: String?
    public var photos: String?
    public var likes: String?
    public var download: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.selfLink   <- map["self"]
        self.html       <- map["html"]
        self.photos     <- map["photos"]
        self.likes      <- map["likes"]
    }
    
}
