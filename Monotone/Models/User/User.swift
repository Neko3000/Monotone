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
    public var updatedAt: Date?
    public var username: String?
    public var name: String?
    public var firstName: String?
    public var lastName: String?
    public var instagramUsername: String?
    public var twitterUsername: String?
    public var portfolioUrl: String?
    public var bio: String?
    public var location: Location?
    public var links: Links?
    public var profileImage: ProfileImage?
    public var totalCollections: Int?
    public var totalLikes: Int?
    public var totalPhotos: Int?
    public var acceptedTos: Bool?
    public var followedByUser: Bool?
    public var photos: [Photo]?
//    public var badge:?
//    public var tags:?
    public var followersCount: Int?
    public var followingCount: Int?
    public var allowMessages: Bool?
    public var numericId: Int?
    public var downloads: Int?
//    public var meta?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        updatedAt           <- (map["updated_at"], ISO8601DateTransform())
        username            <- map["username"]
        name                <- map["name"]
        firstName           <- map["first_name"]
        lastName            <- map["last_name"]
        instagramUsername   <- map["instagram_username"]
        twitterUsername     <- map["twitter_username"]
        portfolioUrl        <- map["portfolio_url"]
        bio                 <- map["bio"]
        location            <- map["location"]
        links               <- map["links"]
        profileImage        <- map["profile_image"]
        totalCollections    <- map["total_collections"]
        totalLikes          <- map["total_likes"]
        totalPhotos         <- map["total_photos"]
        acceptedTos         <- map["accepted_tos"]
        followedByUser      <- map["followed_by_user"]
        photos              <- map["photos"]
        followersCount      <- map["followers_count"]
        followingCount      <- map["following_count"]
        allowMessages       <- map["allow_messages"]
        numericId           <- map["numeric_id"]
        downloads           <- map["downloads"]
    }
}
