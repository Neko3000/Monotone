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








