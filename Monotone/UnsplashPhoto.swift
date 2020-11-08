//
//  UnsplashPhoto.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
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

class ProfileImage: Mappable{
    public var small: String?
    public var medium: String?
    public var large: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.small  <- map["small"]
        self.medium <- map["medium"]
        self.large  <- map["large"]
    }
}



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

class Urls: Mappable{
    public var raw: String?
    public var full: String?
    public var regular: String?
    public var small: String?
    public var thumb: String?

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

class Photo: Mappable{
    public var id: String?
    public var createAt: Date?
    public var width: Int?
    public var height: Int?
    public var color: String?
    public var blurHash: String?
    public var likes: Int?
    public var likedByUser: Bool?
    public var description: String?
    public var user: User?
    //    public var currentUserCollections:
    public var urls: Urls?
    public var links: Links?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id             <- map["id"]
        self.createAt       <- (map["created_at"], ISO8601DateTransform())
        self.width          <- map["width"]
        self.height         <- map["height"]
        self.color          <- map["color"]
        self.blurHash       <- map["blur_hash"]
        self.likes          <- map["likes"]
        self.likedByUser    <- map["liked_by_user"]
        self.description    <- map["description"]
        self.user           <- map["user"]
//        self.currentUserCollections       <- map["current_user_collections"]
        self.urls           <- map["urls"]
        self.links          <- map["linkes"]
    }
}
