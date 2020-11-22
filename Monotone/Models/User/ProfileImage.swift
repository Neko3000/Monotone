//
//  ProfileImage.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class ProfileImage: Mappable{
    public var small: String?
    public var medium: String?
    public var large: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.small  <- map["small"]
        self.medium <- map["medium"]
        self.large  <- map["large"]
    }
}
