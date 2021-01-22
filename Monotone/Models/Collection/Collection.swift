//
//  Collection.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/8.
//

import Foundation
import ObjectMapper

class Collection:Equatable, Mappable{

    var id: String?
    var title: String?
    var coverPhoto: Photo?
    var description: String?
    var publishedAt: Date?
    var lastCollectedAt: Date?
    var updatedAt: Date?
    var totalPhotos: Int?
    var previewPhotos: [Photo]?
    var sponsorship: Sponsorship?
    var user: User?
    var shareKey: String?
    var links: Links?
    var isPrivate: Bool?
    // meta : title description index
    
    init() {
        
    }

    required init?(map: Map) {
        self.mapping(map: map)
    }

    func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        coverPhoto      <- map["cover_photo"]
        description     <- map["description"]
        publishedAt     <- (map["published_at"], ISO8601DateTransform())
        lastCollectedAt <- (map["last_collected_at"], ISO8601DateTransform())
        updatedAt       <- (map["updated_at"], ISO8601DateTransform())
        user            <- map["user"]
        totalPhotos     <- map["total_photos"]
        previewPhotos   <- map["preview_photos"]
        sponsorship     <- map["sponsorship"]
        user            <- map["user"]
        shareKey        <- map["share_key"]
        links           <- map["links"]
        isPrivate       <- map["private"]
    }
    
    static func == (lhs: Collection, rhs: Collection) -> Bool {
        return lhs.id == rhs.id
    }
}








