//
//  User.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/10.
//

import Foundation
import ObjectMapper

class User: Mappable{
    
    public var id: String?
    public var username: String?
    public var name: String?
    public var firstName: String?
    public var lastName: String?
    public var instagramUsername: String?
    public var twitterUsername: String?
    public var protfolioUrl: String?
    public var profileImage: ProfileImage?
    public var links: Links?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id                 <- map["id"]
        self.username           <- map["username"]
        self.name               <- map["name"]
        self.firstName          <- map["first_name"]
        self.lastName           <- map["last_name"]
        self.instagramUsername  <- map["instagram_username"]
        self.twitterUsername    <- map["twitter_username"]
        self.protfolioUrl       <- map["portfolio_url"]
        self.profileImage       <- map["profile_image"]
    }
}
