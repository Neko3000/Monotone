//
//  UnsplashPhoto.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class Photo: Mappable{
    public var id: String?
    public var createdAt: Date?
    public var updatedAt: Date?
    public var promotedAt: Date?
    public var width: Int?
    public var height: Int?
    public var color: String?
    public var blurHash: String?
    public var description: String?
    public var altDescription: String?
    public var urls: Urls?
    public var links: Links?
//    public var categories: []?
//    public var sponsorship: String?
    public var likes: Int?
    public var likedByUser: Bool?
//    public var currentUserCollections:[]?
    public var user: User?
    public var exif: Exif?
    public var location: Location?
//    public var meta:?
//    public var tags:?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id             <- map["id"]
        createdAt      <- (map["created_at"], ISO8601DateTransform())
        updatedAt      <- (map["updated_at"], ISO8601DateTransform())
        promotedAt     <- (map["promoted_at"], ISO8601DateTransform())
        width          <- map["width"]
        height         <- map["height"]
        color          <- map["color"]
        blurHash       <- map["blur_hash"]
        description    <- map["description"]
        altDescription <- map["alt_description"]
        urls           <- map["urls"]
        links          <- map["linkes"]
        likes          <- map["likes"]
        likedByUser    <- map["liked_by_user"]
        likedByUser    <- map["liked_by_user"]
        user           <- map["user"]
        exif           <- map["exif"]
        location       <- map["location"]
    }
}








